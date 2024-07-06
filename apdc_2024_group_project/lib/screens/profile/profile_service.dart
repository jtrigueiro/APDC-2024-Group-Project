import 'dart:typed_data';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  Future<Uint8List?> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imageBase64 = prefs.getString('profile_image');
    if (imageBase64 != null) {
      return base64Decode(imageBase64);
    }
    return null;
  }

  Future<void> saveImage(Uint8List imageBytes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imageBase64 = base64Encode(imageBytes);
    await prefs.setString('profile_image', imageBase64);
  }
}
