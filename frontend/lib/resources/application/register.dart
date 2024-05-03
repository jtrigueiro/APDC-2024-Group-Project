import 'dart:convert';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:http/http.dart' as http;

class Register {
  static Future<bool> registerUser(
      String username,
      String password,
      String name,
      String phoneNumber,
      String email,
      String job,
      String workPlace,
      String homeAddress,
      String postalCode,
      String nif,
      bool privacy) async {
    final result = await fetchRegister(username, password, name, phoneNumber,
        email, job, workPlace, homeAddress, postalCode, nif, privacy);
    return result;
  }

  static Future<bool> fetchRegister(
      String username,
      String password,
      String name,
      String phoneNumber,
      String email,
      String job,
      String workPlace,
      String homeAddress,
      String postalCode,
      String nif,
      bool privacy) async {
    final response = await http.post(
      Uri.parse(
          "https://consummate-link-415914.oa.r.appspot.com/rest/register/"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "username": username,
        "password": password,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "job": job,
        "workPlace": workPlace,
        "address": homeAddress,
        "postalCode": postalCode,
        "NIF": nif,
        'isPrivate': privacy
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
