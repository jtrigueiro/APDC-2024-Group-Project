class Reservation {
  String userID, userName, restaurantID, restaurantName;
  Map<String, int> order;
  double cost;
  DateTime start, end;

  Reservation({required this.userID, required this.userName, required this.restaurantID, required this.restaurantName, required this.start, required this.end, required this.order, required this.cost});
}