import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:adc_group_project/services/models/restaurant.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavoriteRestaurant> favoriteRestaurants = [];
  bool isLoading = false;
  bool hasMore = true;
  DocumentSnapshot? lastDocument;
  static const int pageSize = 10;

  @override
  void initState() {
    super.initState();
    _getFavoriteRestaurants();
  }

  Future<void> _getFavoriteRestaurants() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        isLoading = false;
        hasMore = false;
      });
      return;
    }

    Query query = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favoriteRestaurants')
        .limit(pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    QuerySnapshot favoriteSnapshot = await query.get();

    if (favoriteSnapshot.docs.isEmpty) {
      setState(() {
        isLoading = false;
        hasMore = false;
      });
      return;
    }

    List<FavoriteRestaurant> newRestaurants = [];
    for (var doc in favoriteSnapshot.docs) {
      DocumentSnapshot restaurantDoc = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(doc.id)
          .get();

      String imageUrl = await FirebaseStorage.instance
          .ref('/restaurants/${restaurantDoc.id}/profile/image')
          .getDownloadURL();

      newRestaurants
          .add(FavoriteRestaurant.fromFirestore(restaurantDoc, imageUrl));
    }

    setState(() {
      favoriteRestaurants.addAll(newRestaurants);
      lastDocument = favoriteSnapshot.docs.last;
      isLoading = false;
      hasMore = newRestaurants.length == pageSize;
    });
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
      favoriteRestaurants = [];
      lastDocument = null;
      hasMore = true;
    });
    _getFavoriteRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurants'),
      ),
      body: favoriteRestaurants.isEmpty && isLoading
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  _getFavoriteRestaurants();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: favoriteRestaurants.length +
                    (isLoading
                        ? 1
                        : 0), // Adicionar um item a mais para o indicador de carregamento
                itemBuilder: (context, index) {
                  if (index == favoriteRestaurants.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final restaurant = favoriteRestaurants[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          restaurant.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/burger.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
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
                      onTap: () {
                        var restaurantDetail = Restaurant(
                          id: restaurant.id,
                          name: restaurant.name,
                          address: restaurant.address,
                          phone: restaurant.phone,
                          location: restaurant.location,
                          coordinates: restaurant.coordinates,
                          co2EmissionEstimate: restaurant.co2EmissionEstimate,
                          seats: restaurant.seats,
                          visible: restaurant.visible,
                          isOpen: restaurant.isOpen,
                          time: restaurant.time,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RestaurantScreen(info: restaurantDetail),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class FavoriteRestaurant {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final double co2EmissionEstimate;
  final String phone;
  final String location;
  final String coordinates;
  final int seats;
  final bool visible;
  final List<bool> isOpen;
  final List<String> time;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.co2EmissionEstimate,
    required this.phone,
    required this.location,
    required this.coordinates,
    required this.seats,
    required this.visible,
    required this.isOpen,
    required this.time,
  });

  factory FavoriteRestaurant.fromFirestore(
      DocumentSnapshot doc, String imageUrl) {
    Map data = doc.data() as Map<String, dynamic>;
    return FavoriteRestaurant(
      id: doc.id,
      name: data['name'],
      address: data['address'],
      imageUrl: imageUrl,
      co2EmissionEstimate: (data['co2EmissionEstimate'] as num).toDouble(),
      phone: data['phone'],
      location: data['location'],
      coordinates: data['coordinates'],
      seats: data['seats'],
      visible: data['visible'],
      isOpen: List<bool>.from(data['isOpen']),
      time: List<String>.from(data['time']),
    );
  }
}
