class RestaurantApplication {
  final String uid, name, phone, location, address, coordinates;
  final int seats;
  final List<String> types;

  RestaurantApplication({
    required this.uid,
    required this.name,
    required this.phone,
    required this.location,
    required this.address,
    required this.seats,
    required this.coordinates,
    required this.types,
  });
}
