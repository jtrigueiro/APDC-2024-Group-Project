import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String location;
  final String coordinates;
  final double co2EmissionEstimate;
  final int seats;
  final bool visible;
  final List<bool> isOpen;
  final List<String> time;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.location,
    required this.coordinates,
    required this.co2EmissionEstimate,
    required this.seats,
    required this.visible,
    required this.isOpen,
    required this.time,
  });

  factory Restaurant.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Restaurant(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      location: data['location'] ?? '',
      coordinates: data['coordinates'] ?? '',
      co2EmissionEstimate: data['co2EmissionEstimate'] ?? 0.0,
      seats: data['seats'] ?? 0,
      visible: data['visible'] ?? false,
      time: List<String>.from(data['time'] ?? []),
      isOpen: List<bool>.from(data['isOpen'] ?? []),
    );
  }
}
