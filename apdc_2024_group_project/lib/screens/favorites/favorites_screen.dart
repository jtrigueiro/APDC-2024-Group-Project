import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Restaurant {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final String co2EmissionEstimate;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.co2EmissionEstimate,
  });

  factory Restaurant.fromFirestore(DocumentSnapshot doc, String imageUrl) {
    Map data = doc.data() as Map<String, dynamic>;
    return Restaurant(
      id: doc.id,
      name: data['name'].toString(),
      address: data['address'].toString(),
      imageUrl: imageUrl,
      co2EmissionEstimate: data['co2EmissionEstimate'].toString(),
    );
  }
}

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Restaurant>> favoriteRestaurants;

  @override
  void initState() {
    super.initState();
    favoriteRestaurants = _getFavoriteRestaurants();
  }

  Future<List<Restaurant>> _getFavoriteRestaurants() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    QuerySnapshot favoriteSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favoriteRestaurants')
        .get();

    List<Restaurant> favoriteRestaurants = [];

    for (var doc in favoriteSnapshot.docs) {
      DocumentSnapshot restaurantDoc = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(doc.id)
          .get();

      String imageUrl = await FirebaseStorage.instance
          .ref('/restaurants/${restaurantDoc.id}/profile/image')
          .getDownloadURL();

      favoriteRestaurants
          .add(Restaurant.fromFirestore(restaurantDoc, imageUrl));
    }

    return favoriteRestaurants;
  }

  Future<void> _removeFavorite(String restaurantId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    DocumentReference userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favoriteRestaurants')
        .doc(restaurantId);

    await userDoc.delete();
    setState(() {
      favoriteRestaurants = _getFavoriteRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurants'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: favoriteRestaurants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite restaurants'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final restaurant = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: Image.network(
                      restaurant.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    title: Text(restaurant.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Average Footprint: ${restaurant.co2EmissionEstimate}'),
                        Text('Address: ${restaurant.address}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        _removeFavorite(restaurant.id);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
