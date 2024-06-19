import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final String uid;
  //DatabaseService({required this.uid});

  // users collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // restaurants applications collection reference
  final CollectionReference restaurantsApplicationsCollection =
      FirebaseFirestore.instance.collection('restaurants_applications');

  // restaurants collection reference
  final CollectionReference restaurantsCollection =
      FirebaseFirestore.instance.collection('restaurants');

  // ----------------- User -----------------
  // add or update user data
  Future addOrUpdateUserData(String uid, String name) async {
    try {
      await usersCollection.doc(uid).set({
        'name': name,
      });
      return true;
    } catch (e) {
      print(e.toString());
      //TODO: need to handle an error on auth
      return null;
    }
  }

  // ----------------- Search Restaurants -----------------

  Future<List<Map<String, dynamic>>> getAllRestaurants() async {
    try {
      final QuerySnapshot result = await restaurantsCollection.get();
      return result.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getRestaurantsbyLocation(String location) async {
    try {
      final QuerySnapshot result = await restaurantsCollection
          .where('location', isEqualTo: location)
          .get();
      return result.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }


  Future<List<Map<String, dynamic>>> searchRestaurants(String search) async {
    try {
      final QuerySnapshot result = await restaurantsCollection
          .where('name', isGreaterThanOrEqualTo: search)
          .get();
      return result.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // ----------------- My Restaurant -----------------
  // add or update a restaurant application
  Future addOrUpdateRestaurantApplicationData(
      String name, String phone, String location) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsApplicationsCollection.doc(user!.uid).set({
        'name': name,
        'phone': phone,
        'location': location,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // has a restaurant application
  Future hasRestaurantApplication() async {
    User? user = _auth.currentUser;
    try {
      final DocumentSnapshot doc =
          await restaurantsApplicationsCollection.doc(user!.uid).get();
      return doc.exists;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //has a restaurant
  Future hasRestaurant() async {
    User? user = _auth.currentUser;
    try {
      final DocumentSnapshot doc =
          await restaurantsCollection.doc(user!.uid).get();
      return doc.exists;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ----------------- BackOffice -----------------
  // restaurant application from snapshot
  List<RestaurantApplication> _restaurantsApplicationsListFromSnapshot(
      QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return RestaurantApplication(
          uid: doc.id ?? '',
          name: doc.get('name') ?? '',
          phone: doc.get('phone') ?? '',
          location: doc.get('location') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // get restaurants applications stream
  Stream<List<RestaurantApplication>> get restaurantsApplications {
    try {
      return restaurantsApplicationsCollection
          .snapshots()
          .map(_restaurantsApplicationsListFromSnapshot);
    } catch (e) {
      print(e.toString());
      return Stream.empty();
    }
  }

  // delete restaurant application
  Future deleteRestaurantApplication(String uid) async {
    try {
      await restaurantsApplicationsCollection.doc(uid).delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // add or update restaurant data
  Future addOrUpdateRestaurantData(
      String uid, String name, String phone, String location) async {
    try {
      await restaurantsCollection.doc(uid).set({
        'name': name,
        'phone': phone,
        'location': location,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
