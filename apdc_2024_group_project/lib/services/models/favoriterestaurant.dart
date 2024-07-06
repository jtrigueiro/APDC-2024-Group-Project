import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteRestaurant {
  final String id;
  final String name;
  final String address;
  final double co2EmissionEstimate;
  final String phone;
  final String location;
  final String coordinates;
  final int seats;
  final bool visible;
  final List<bool> isOpen;
  final List<String> time;
  final DocumentSnapshot? documentSnapshot;
  String? imageUrl;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.co2EmissionEstimate,
    required this.phone,
    required this.location,
    required this.coordinates,
    required this.seats,
    required this.visible,
    required this.isOpen,
    required this.time,
    this.documentSnapshot,
    this.imageUrl,
  });

  factory FavoriteRestaurant.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return FavoriteRestaurant(
      id: doc.id,
      name: data['name'],
      address: data['address'],
      co2EmissionEstimate: (data['co2EmissionEstimate'] as num).toDouble(),
      phone: data['phone'],
      location: data['location'],
      coordinates: data['coordinates'],
      seats: data['seats'],
      visible: data['visible'],
      isOpen: List<bool>.from(data['isOpen']),
      time: List<String>.from(data['time']),
      documentSnapshot: doc,
    );
  }
}
