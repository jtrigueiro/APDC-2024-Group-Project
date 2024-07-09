import 'package:http/http.dart' as http;
import 'dart:convert';

class GeocodingService {
  static const String apiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug';

  Future<Map<String, dynamic>> geocode(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final decodedResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
      throw Exception('Failed to geocode address');
    }
  }

  Future<Map<String, dynamic>> reverseGeocode(double latitude, double longitude) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final decodedResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
      throw Exception('Failed to reverse geocode coordinates');
    }
  }

  Future<Map<String, dynamic>> getDistance(double originLatitude, double originLongitude, double destinationLatitude, double destinationLongitude) async {
    final url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$originLatitude,$originLongitude&destinations=$destinationLatitude,$destinationLongitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final decodedResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
      throw Exception('Failed to get distance between coordinates');
    }
  }
}