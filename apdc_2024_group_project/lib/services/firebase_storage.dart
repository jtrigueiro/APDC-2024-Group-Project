import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// firebase storage service
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String dishImagePath(String uid, String dishId) {
    return 'restaurants/$uid/dishes/$dishId';
  }

  String restaurantImagePath(String uid) {
    return 'restaurants/$uid/profile/image';
  }

  String restaurantProofDocumentPath(String uid, String fileName) {
    return 'restaurants/$uid/ProofDocuments/$fileName';
  }

  String restaurantProofDocumentFolderPath(String uid) {
    return 'restaurants/$uid/ProofDocuments';
  }

  Future uploadDishImageMobile(
      String uid, String dishId, String imagePath) async {
    final path = dishImagePath(uid, dishId);
    final ref = _storage.ref().child(path);
    await ref.putFile(File(imagePath));
  }

  Future uploadDishImageWeb(String uid, String dishId, Uint8List imageBytes,
      String imageExtension) async {
    final path = dishImagePath(uid, dishId);
    final ref = _storage.ref().child(path);
    final extensionName = imageExtension.split('.').last;
    final metadata = SettableMetadata(contentType: 'image/$extensionName');
    await ref.putData(imageBytes, metadata);
  }

  Future deleteDishImage(String uid, String dishId) async {
    final path = dishImagePath(uid, dishId);
    final ref = _storage.ref().child(path);
    await ref.delete();
  }

  Future<String> getDishImageUrl(String uid, String dishId) async {
    final path = dishImagePath(uid, dishId);
    final ref = _storage.ref().child(path);
    return await ref.getDownloadURL();
  }

  Future uploadRestaurantImageMobile(String uid, String imagePath) async {
    final path = restaurantImagePath(uid);
    final ref = _storage.ref().child(path);
    await ref.putFile(File(imagePath));
  }

  Future uploadRestaurantImageWeb(
      String uid, Uint8List imageBytes, String imageExtension) async {
    final path = restaurantImagePath(uid);
    final ref = _storage.ref().child(path);
    final extensionName = imageExtension.split('.').last;
    final metadata = SettableMetadata(contentType: 'image/$extensionName');
    await ref.putData(imageBytes, metadata);
  }

  Future getRestaurantImageUrl(String uid) async {
    final path = restaurantImagePath(uid);
    final ref = _storage.ref().child(path);
    return await ref.getDownloadURL();
  }

  Future<String?> uploadFile(
      Uint8List fileBytes, String fileName, User user) async {
    String uid = user.uid;
    final path = restaurantProofDocumentPath(uid, fileName);
    final storageRef = _storage.ref().child(path);
    final metadata = SettableMetadata(contentType: 'application/pdf');
    await storageRef.putData(fileBytes, metadata);
    return await storageRef.getDownloadURL();
  }

  Future<String> getProofDocumentUrl(String uid, String fileName) async {
    final path = restaurantProofDocumentPath(uid, fileName);
    final ref = _storage.ref().child(path);
    return await ref.getDownloadURL();
  }

  Future deleteRestaurant(String restaurantId) async {
    //delete restaurant image
    final path = restaurantImagePath(restaurantId);
    final ref = _storage.ref().child(path);
    await ref.delete();

    // delete proof documents
    final proofDocumentsPath = restaurantProofDocumentFolderPath(restaurantId);
    final proofDocumentsRef = _storage.ref().child(proofDocumentsPath);
    final ListResult result = await proofDocumentsRef.listAll();
    for (final item in result.items) {
      await item.delete();
    }
  }
}
