class Reservation {
  String userID, userName, restaurantID, restaurantName;
  List<String> order;
  double cost, averageEmissions;
  DateTime start, end;

  Reservation({required this.userID, required this.userName, required this.restaurantID, required this.restaurantName,
   required this.start, required this.end, required this.order, required this.cost, required this.averageEmissions});
}