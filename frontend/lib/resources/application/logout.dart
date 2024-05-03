import 'dart:convert';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:http/http.dart' as http;

class Logout {
  static Future<bool> logoutUser() async {
    final result = await fetchLogout();
    return result;
  }

  static Future<bool> fetchLogout() async {
    final response = await http.delete(
      Uri.parse("https://consummate-link-415914.oa.r.appspot.com/rest/logout/"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<dynamic, dynamic>{
        "token": {
          "username": await Authentication.getTokenUsername(),
          "tokenID": await Authentication.getTokenId(),
          "creationData": await Authentication.getTokenCreationData(),
          "expirationData": await Authentication.getTokenExpirationData(),
        },
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return true;
    } else {
      return false;
    }
  }
}
