import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/reservation.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';

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
      subtitle: Text('${reservation.start.day}/${reservation.start.month}/${reservation.start.year}'),
      onTap: () {
        showReservationDetails(reservation);
      },
    );
  }

  void showReservationDetails(Reservation reservation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reservation Details'),
          content: SizedBox(
            height: 200,
            width: 300,
            child: Column(
              children: [
                Text('Restaurant: ${reservation.restaurantName}'),
                Text('Date: ${reservation.start.day}/${reservation.start.month}/${reservation.start.year}'),
                Text('Time: ${reservation.start.hour}:${reservation.start.minute}'),
                Text('Total Price: ${reservation.cost}'),
                ListView.builder(
                  itemCount: reservation.order.length,
                  itemBuilder: (context, index) {
                    return Text(reservation.order[index]);
                  },
                ),
              ],
            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
      body: fetchingReservations ? const LoadingScreen()
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
