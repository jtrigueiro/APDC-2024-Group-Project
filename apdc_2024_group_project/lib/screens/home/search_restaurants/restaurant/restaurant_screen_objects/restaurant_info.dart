import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantInfo extends StatefulWidget {
  const RestaurantInfo({required this.info, Key? key}) : super(key: key);

  final Restaurant info;

  @override
  _RestaurantInfoState createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  bool isFavorite = false;
  bool isLoading = true;

  final DatabaseService _restaurantService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    try {
      bool favoriteStatus =
          await _restaurantService.checkIfFavorite(widget.info.id);
      setState(() {
        isFavorite = favoriteStatus;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load favorites: $e')),
      );
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      await _restaurantService.toggleFavorite(widget.info.id, isFavorite);
      setState(() {
        isFavorite = !isFavorite;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(isFavorite
                ? 'Added to favorites!'
                : 'Removed from favorites!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update favorites: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.info.name} - ${widget.info.address}",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          'assets/images/restaurant1.png',
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.eco, color: Colors.green),
                              const SizedBox(width: 4.0),
                              Text(
                                "${widget.info.co2EmissionEstimate} CO2e",
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border),
                            iconSize: 20,
                            onPressed: _toggleFavorite,
                          ),
                        ],
                      ),
                      const Text(
                        "*average per dish",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
