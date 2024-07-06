import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/favoriterestaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  final DatabaseService _firebaseService = DatabaseService();
  final StorageService _storageService = StorageService();

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

    List<FavoriteRestaurant> newRestaurants = await _firebaseService
        .getFavoriteRestaurants(lastDocument: lastDocument, pageSize: pageSize);

    for (var restaurant in newRestaurants) {
      restaurant.imageUrl =
          await _storageService.getRestaurantImageUrl(restaurant.id);
    }

    if (newRestaurants.isEmpty) {
      setState(() {
        isLoading = false;
        hasMore = false;
      });
      return;
    }

    setState(() {
      favoriteRestaurants.addAll(newRestaurants);
      lastDocument = newRestaurants.last.documentSnapshot;
      isLoading = false;
      hasMore = newRestaurants.length == pageSize;
    });
  }

  Future<void> _removeFavorite(String restaurantId) async {
    await _firebaseService.removeFavoriteRestaurant(restaurantId);
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
        title: const Text('Favorite Restaurants'),
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
                itemCount: favoriteRestaurants.length + (isLoading ? 1 : 0),
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
                          restaurant.imageUrl ?? '',
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
                              'Average CO2: ${restaurant.co2EmissionEstimate}'),
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
