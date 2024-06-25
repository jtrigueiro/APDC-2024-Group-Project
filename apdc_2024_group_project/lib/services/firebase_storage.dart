import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

// firebase storage service
class StorageService {
  String dishImagePath(String uid, String dishId) {
    return 'users/$uid/myrestaurant/dishes/$dishId';
  }

  Future uploadDishImage(String uid, String dishId, String filePath) async {
    final path = dishImagePath(uid, dishId);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(File(filePath));
  }
}
