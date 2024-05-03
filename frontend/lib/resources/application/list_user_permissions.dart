import 'dart:convert';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:http/http.dart' as http;

class ListUserPermissions {
  static Future<String> listUserPermissions() async {
    final result = await fetchUserPerimissions();
    return result;
  }

  static Future<String> fetchUserPerimissions() async {
    final response = await http.post(
      Uri.parse(
          "https://consummate-link-415914.oa.r.appspot.com/rest/list/user/permissions"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "token": {
          "username": await Authentication.getTokenUsername(),
          "tokenID": await Authentication.getTokenId(),
          "creationData": await Authentication.getTokenCreationData(),
          "expirationData": await Authentication.getTokenExpirationData(),
        },
      }),
    );
    await Authentication.saveResponse(response.body.toString());
    String permissions = (await jsonDecode(response.body)).toString();

    return permissions;
  }
}
