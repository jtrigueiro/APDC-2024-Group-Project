import 'dart:convert';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:http/http.dart' as http;

class ChangePassword {
  static Future<bool> changePassword(
      String password, String newPassword) async {
    final result = await fetchPassword(password, newPassword);
    return result;
  }

  static Future<bool> fetchPassword(String password, String newPassword) async {
    final response = await http.put(
      Uri.parse(
          "https://consummate-link-415914.oa.r.appspot.com/rest/edit/password"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "password": password,
        "newPassword": newPassword,
        "token": {
          "username": await Authentication.getTokenUsername(),
          "tokenID": await Authentication.getTokenId(),
          "creationData": await Authentication.getTokenCreationData(),
          "expirationData": await Authentication.getTokenExpirationData(),
        },
      }),
    );
    await Authentication.saveResponse(response.body.toString());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      return true;
    } else {
      return false;
    }
  }
}
