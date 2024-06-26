import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

// firebase storage service
class StorageService {
  String dishImagePath(String uid, String dishId) {
    return 'restaurants/$uid/dishes/$dishId';
  }

  Future uploadDishImage(String uid, String dishId, String imagePath) async {
    final path = dishImagePath(uid, dishId);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(File(imagePath));
  }

  Future uploadDishImageWeb(String uid, String dishId, Uint8List imageBytes,
      String imageExtension) async {
    final path = dishImagePath(uid, dishId);
    final ref = FirebaseStorage.instance.ref().child(path);
    final extensionName = imageExtension.split('.').last;
    final metadata = SettableMetadata(contentType: 'image/$extensionName');
    ref.putData(imageBytes, metadata);
  }
}
