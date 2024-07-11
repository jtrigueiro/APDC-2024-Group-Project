import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:adc_group_project/utils/constants.dart' as constants;

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
      constants.showSnackBar(context, 'Failed to load favorites: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      await _restaurantService.toggleFavorite(widget.info.id, isFavorite);
      setState(() {
        isFavorite = !isFavorite;
      });
      constants.showSnackBar(context, isFavorite
          ? 'Added to favorites!'
          : 'Removed from favorites!');
    } catch (e) {
      constants.showSnackBar(context, 'Failed to update favorites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                      widget.info.name,
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                  Text(
                      widget.info.address,
                      style: Theme.of(context).textTheme.titleSmall
                  ),
                  const Padding(
                    padding:  EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child:  Icon(
                      Icons.star,
                      color: Colors.amberAccent,
                      size: 23,
                    ),
                  ),
                  widget.info.imageUrl !=''
                  ?
                  ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(widget.info.imageUrl,
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      )
                      :
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: Text('no image'),
                    )
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.eco, color: Colors.green),
                          ),
                          Text(
                            "${widget.info.co2EmissionEstimate.toStringAsPrecision(5)} CO2e",
                            style: Theme.of(context).textTheme.titleSmall,
                            ),
                        ],
                      ),

                      IconButton(
                        icon: Icon(isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,color: const Color.fromARGB( 255, 227, 57, 57),),
                        iconSize: 30,
                        onPressed: _toggleFavorite,
                      ),
                    ],
                  ),

                   Text(
                    "*average per dish",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 8.5),
                  ),
                ],
              ),
            ),
          );
  }
}
