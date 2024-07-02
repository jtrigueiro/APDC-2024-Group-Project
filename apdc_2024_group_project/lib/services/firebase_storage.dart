import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

// firebase storage service
class StorageService {
  String dishImagePath(String uid, String dishId) {
    return 'restaurants/$uid/dishes/$dishId';
  }

  String restaurantImagePath(String uid) {
    return 'restaurants/$uid/profile/image';
  }

  Future uploadDishImageMobile(
      String uid, String dishId, String imagePath) async {
    final path = dishImagePath(uid, dishId);
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(File(imagePath));
  }

  Future uploadDishImageWeb(String uid, String dishId, Uint8List imageBytes,
      String imageExtension) async {
    final path = dishImagePath(uid, dishId);
    final ref = FirebaseStorage.instance.ref().child(path);
    final extensionName = imageExtension.split('.').last;
    final metadata = SettableMetadata(contentType: 'image/$extensionName');
    await ref.putData(imageBytes, metadata);
  }

  Future deleteDishImage(String uid, String dishId) async {
    final path = dishImagePath(uid, dishId);
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.delete();
  }

  Future<String> getDishImageUrl(String uid, String dishId) async {
    final path = dishImagePath(uid, dishId);
    final ref = FirebaseStorage.instance.ref().child(path);
    return await ref.getDownloadURL();
  }

  Future uploadRestaurantImageMobile(String uid, String imagePath) async {
    final path = restaurantImagePath(uid);
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(File(imagePath));
  }

  Future uploadRestaurantImageWeb(
      String uid, Uint8List imageBytes, String imageExtension) async {
    final path = restaurantImagePath(uid);
    final ref = FirebaseStorage.instance.ref().child(path);
    final extensionName = imageExtension.split('.').last;
    final metadata = SettableMetadata(contentType: 'image/$extensionName');
    await ref.putData(imageBytes, metadata);
  }

  Future getRestaurantImageUrl(String uid) async {
    final path = restaurantImagePath(uid);
    final ref = FirebaseStorage.instance.ref().child(path);
    return await ref.getDownloadURL();
  }
}
