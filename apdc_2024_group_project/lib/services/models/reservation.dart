class Reservation {
  String userID, restaurantID;
  List<String> order;
  double cost;
  DateTime start;
  DateTime end;

  Reservation({required this.userID, required this.restaurantID, required this.start, required this.end, required this.order, required this.cost});
}