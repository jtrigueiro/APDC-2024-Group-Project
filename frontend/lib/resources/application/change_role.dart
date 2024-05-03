import 'dart:convert';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:http/http.dart' as http;

class ChangeRole {
  static Future<bool> changeUserRole(
    String targetUsername,
    String newRole,
  ) async {
    final result = await fetchRole(targetUsername, newRole);
    return result;
  }

  static Future<bool> fetchRole(
    String targetUsername,
    String newRole,
  ) async {
    final response = await http.put(
      Uri.parse(
          "https://consummate-link-415914.oa.r.appspot.com/rest/changepersmissions/role"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<dynamic, dynamic>{
        "targetUsername": targetUsername,
        "newRole": newRole,
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
