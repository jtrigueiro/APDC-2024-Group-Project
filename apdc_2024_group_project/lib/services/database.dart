import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference restaurantsApplicationsCollection =
      FirebaseFirestore.instance.collection('restaurants_applications');

  final CollectionReference restaurantsCollection =
      FirebaseFirestore.instance.collection('restaurants');

  Future updateUserData(String name) async {
    return await usersCollection.doc(uid).set({
      'name': name,
    });
  }

  Future updateRestaurantApplicationData(
      String name, String phone, String location) async {
    return await restaurantsApplicationsCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'location': location,
    });
  }

  Future updateRestaurantData(
      String name, String phone, String location) async {
    return await restaurantsCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'location': location,
    });
  }

  // user has a restaurant application
  Future<bool> hasRestaurantApplication() async {
    final DocumentSnapshot doc =
        await restaurantsApplicationsCollection.doc(uid).get();
    return doc.exists;
  }
}
