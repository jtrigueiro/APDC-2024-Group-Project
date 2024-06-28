class RestaurantApplication {
  final String uid,
      name,
      phone,
      location,
      address,
      electricityPdfUrl,
      gasPdfUrl,
      waterPdfUrl,
      coordinates;
  final double co2EmissionEstimate;
  final int numberOfSeats;

  RestaurantApplication({
    required this.uid,
    required this.name,
    required this.phone,
    required this.location,
    required this.address,
    required this.co2EmissionEstimate,
    required this.electricityPdfUrl,
    required this.gasPdfUrl,
    required this.waterPdfUrl,
    required this.numberOfSeats,
    required this.coordinates,
  });
}
