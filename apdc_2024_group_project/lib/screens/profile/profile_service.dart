import 'dart:typed_data';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<String?> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('userName');

    if (name == null) {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userData =
            await _firestore.collection('users').doc(user.uid).get();
        name = userData['name'];
        await prefs.setString('userName', name!);
      }
    }

    return name;
  }
}
