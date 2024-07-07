import 'package:adc_group_project/services/models/dish.dart';

class Reservation {
  String userID, restaurantID;
  List<Dish> order;
  DateTime start;
  DateTime end;

  Reservation({required this.userID, required this.restaurantID, required this.start, required this.end, required this.order});
}