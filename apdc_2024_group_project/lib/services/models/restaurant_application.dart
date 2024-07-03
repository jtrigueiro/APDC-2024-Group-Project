class RestaurantApplication {
  final String uid, name, phone, location, address, coordinates;
  final double co2EmissionEstimate;
  final int seats;

  RestaurantApplication({
    required this.uid,
    required this.name,
    required this.phone,
    required this.location,
    required this.address,
    required this.co2EmissionEstimate,
    required this.seats,
    required this.coordinates,
  });
}
