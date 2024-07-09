import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/reservation.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  ListTile buildReservationTile(Reservation reservation) {
    return ListTile(
      leading: const Icon(Icons.restaurant),
      title: Text(reservation.restaurantName),
      subtitle: Text(
          '${reservation.start.day}/${reservation.start.month}/${reservation.start.year}\n${reservation.start.hour}:${reservation.start.minute == 0 ? '00' : reservation.start.minute}'),
      onTap: () {
        showReservationDetails(reservation);
      },
    );
  }

  void showReservationDetails(Reservation reservation) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Reservation Details',
              textAlign: TextAlign.center,),
          content: Column(
              children: [
                Text('Restaurant: ${reservation.restaurantName}',
                overflow: TextOverflow.ellipsis,),
                
                const SizedBox(height: 10),
                Text(
                    'Date: ${reservation.start.day}/${reservation.start.month}/${reservation.start.year}'),
                Text(
                    'Time: ${reservation.start.hour}:${reservation.start.minute == 0 ? '00' : reservation.start.minute}'),
                const SizedBox(height: 20),
                Text('Total Price: ${reservation.cost}€'),
                Text('Average Emissions: ${reservation.averageEmissions} gCO2'),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...constructMap(reservation.order).entries.map((entry) => ListTile(
                        title: Text('${entry.key} x${entry.value}',
                            textAlign: TextAlign.center,),
                        leading: const Icon(Icons.fastfood),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    }
    else
      {
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
