import 'dart:convert';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:http/http.dart' as http;

class ChangeAttributes {
  static Future<bool> changeUserAttributes(
      String targetUsername,
      String name,
      String phoneNumber,
      String email,
      String job,
      String workPlace,
      String homeAddress,
      String postalCode,
      String nif,
      bool privacy) async {
    final result = await fetchAttributes(targetUsername, name, phoneNumber,
        email, job, workPlace, homeAddress, postalCode, nif, privacy);
    return result;
  }

  static Future<bool> fetchAttributes(
      String targetUsername,
      String name,
      String phoneNumber,
      String email,
      String job,
      String workPlace,
      String homeAddress,
      String postalCode,
      String nif,
      bool privacy) async {
    final response = await http.put(
      Uri.parse(
          "https://consummate-link-415914.oa.r.appspot.com/rest/edit/user"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "targetUsername": targetUsername,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "job": job,
        "workPlace": workPlace,
        "address": homeAddress,
        "postalCode": postalCode,
        "NIF": nif,
        "isPrivate": privacy,
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
