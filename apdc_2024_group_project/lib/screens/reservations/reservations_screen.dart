import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/reservation.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_screen.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  ReservationsScreenState createState() => ReservationsScreenState();
}

class ReservationsScreenState extends State<ReservationsScreen> {
  @override
  void initState() {
    getReservations();
    super.initState();
  }

  bool fetchingReservations = true;
  List<Reservation> reservations = [];

  getReservations() async {
    reservations = await DatabaseService().getUserReservations();

    setState(() {
      fetchingReservations = false;
    });
  }

  Padding buildReservationTile(Reservation reservation) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: const Color.fromARGB(18, 60, 130, 21),
        leading: Icon(Icons.restaurant, color: Theme.of(context).colorScheme.primary,),
        title: Text(reservation.restaurantName),
        subtitle: Text(
            'Date: ${reservation.start.day}/${reservation.start.month}/${reservation.start.year}    Time: ${reservation.start.hour}:${reservation.start.minute == 0 ? '00' : reservation.start.minute}'),
        onTap: () {
          showReservationDetails(reservation);
        },
      ),
    );
  }

  void showReservationDetails(Reservation reservation) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Reservation Details', textAlign: TextAlign.center),
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Restaurant: ${reservation.restaurantName}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text('Date:',
                        style: Theme.of(
                            context)
                            .textTheme
                            .titleSmall),
                  ),
                  Text(
                      ' ${reservation.start.day}/${reservation.start.month}/${reservation.start.year}',
                      style: Theme.of(
                          context)
                          .textTheme
                          .bodyMedium),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text('Time:',
                        style: Theme.of(
                            context)
                            .textTheme
                            .titleSmall),
                  ),
                  Text(
                      ' ${reservation.start.hour}:${reservation.start.minute == 0 ? '00' : reservation.start.minute}',
                      style: Theme.of(
                          context)
                          .textTheme
                          .bodyMedium),
                ],
              ),
              //Text( ${reservation.start.day}/${reservation.start.month}/${reservation.start.year}'),
              //Text('Time: ${reservation.start.hour}:${reservation.start.minute == 0 ? '00' : reservation.start.minute}'),

              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text('Total Price:',
                          style: Theme.of(
                              context)
                              .textTheme
                              .titleSmall),
                    ),
                    Text(
                        ' ${reservation.cost}€',
                        style: Theme.of(
                            context)
                            .textTheme
                            .bodyMedium),
                  ],
                ),
              ),
              //Text('Total Price: ${reservation.cost}€'),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text('Average Emissions:',
                          style: Theme.of(
                              context)
                              .textTheme
                              .titleSmall),
                    ),
                    Text(
                        ' ${reservation.averageEmissions} gCO2',
                        style: Theme.of(
                            context)
                            .textTheme
                            .bodyMedium),
                  ],
                ),
              ),
             // Text('Average Emissions: ${reservation.averageEmissions} gCO2'),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...constructMap(reservation.order).entries.map((entry) =>
                        ListTile(
                          title: Text('${entry.key} x${entry.value}',
                            textAlign: TextAlign.left,),
                          leading: const Icon(Icons.fastfood_outlined),
                        ))
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                LatLng? restaurantLocation = await getRestaurantCoordinates(reservation.restaurantID);
                if (restaurantLocation != null) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapScreen(
                      restaurantLocation: restaurantLocation,
                    ),
                  ));
                } else {
                  // Handle error
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to get restaurant location.'),
                  ));
                }
              },
              child: const Text('Get Directions'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<LatLng?> getRestaurantCoordinates(String restaurantId) async {
    try {
      Restaurant restaurant = await DatabaseService().getRestaurantById(restaurantId);
      if (restaurant.coordinates.isNotEmpty) {
        return LatLng(
          double.parse(restaurant.coordinates.split(',')[0]),
          double.parse(restaurant.coordinates.split(',')[1]),
        );
      }
    } catch (e) {
      debugPrint('Error fetching restaurant coordinates: $e');
    }
    return null;
  }

  Map<String, int> constructMap(List<String> order) {
    final Map<String, int> map = {};
    for (final item in order) {
      if (map.containsKey(item)) {
        map[item] = map[item]! + 1;
      } else {
        map[item] = 1;
      }
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return webScaffold();
    } else {
      return appScaffold();
    }
  }

  webScaffold() {
    return Scaffold(
      body: fetchingReservations
          ? const LoadingScreen()
          : Center(
        child: ListView.builder(
          itemCount: reservations.length,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return buildReservationTile(reservations[index]);
          },
        ),
      ),
    );
  }

  appScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
      body: fetchingReservations
          ? const LoadingScreen()
          : Center(
        child: ListView.builder(
          itemCount: reservations.length,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return buildReservationTile(reservations[index]);
          },
        ),
      ),
    );
  }
}
