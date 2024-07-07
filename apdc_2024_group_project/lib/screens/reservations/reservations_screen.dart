import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_screen.dart';

class ReservationsScreen extends StatelessWidget {
  ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservations'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Simulated Reservation 1'),
              subtitle: Text('Restaurant Name 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      restaurantLocation: LatLng(38.63951135342269, -9.154002586507383),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Simulated Reservation 2'),
              subtitle: Text('Restaurant Name 2'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      restaurantLocation: LatLng(38.6258528, -9.1222159),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Simulated Reservation 3'),
              subtitle: Text('Restaurant Name 3'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      restaurantLocation: LatLng(38.6180722, -9.1047471),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
