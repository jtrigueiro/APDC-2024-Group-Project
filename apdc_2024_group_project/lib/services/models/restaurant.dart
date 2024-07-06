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
}
