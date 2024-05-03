import 'dart:convert';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:http/http.dart' as http;

class ListUser {
  static Future<List> listUser() async {
    final result = await fetchListUser();
    return result;
  }

  static Future<List> fetchListUser() async {
    final response = await http.post(
      Uri.parse(
          "https://consummate-link-415914.oa.r.appspot.com/rest/list/user"),
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
    List users = await jsonDecode(response.body);

    return users;
  }
}
