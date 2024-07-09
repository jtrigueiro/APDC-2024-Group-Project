import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/favoriterestaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  Widget noFavorites(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 150,
                color: Color.fromARGB(255, 246, 96, 96),
              ),
              Icon(
                Icons.eco,
                size: 50,
                color: Color.fromARGB(255, 188, 255, 148),
              ),
            ],
          ),
          Text(
            'You have no favorites yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(body: appandWeb());
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite Restaurants'),
          ),
          body: appandWeb());
    }
  }

  appandWeb() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : favoriteRestaurants.isEmpty
            ? noFavorites(context)
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
                      return const Center(child: CircularProgressIndicator());
                    }
                    final restaurant = favoriteRestaurants[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            restaurant.imageUrl ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/burger.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        title: Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Average CO2:',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontSize: 12)),
                            Text('${restaurant.co2EmissionEstimate}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontSize: 12)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 227, 57, 57),
                          ),
                          onPressed: () {
                            _removeFavorite(restaurant.id);
                          },
                        ),
                        onTap: () {
                          var restaurantDetail = Restaurant(
                            imageUrl: restaurant.imageUrl!,
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
                              builder: (context) => RestaurantScreen(
                                  info: restaurantDetail, day: null),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
  }
}
