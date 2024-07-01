class Restaurant {
  String id, name, address, phone, location, coordinates;
  double co2EmissionEstimate;
  int seats;
  bool visible;
  List<bool> isOpen;
  List<String> time;

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
}
