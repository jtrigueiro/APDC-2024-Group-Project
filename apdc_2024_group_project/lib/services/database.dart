import 'dart:async';
import 'dart:typed_data';

import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final String uid;
  //DatabaseService({required this.uid});
  // Storage do Firebase
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // users collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // restaurants applications collection reference
  final CollectionReference restaurantsApplicationsCollection =
      FirebaseFirestore.instance.collection('restaurants_applications');

  // restaurants collection reference
  final CollectionReference restaurantsCollection =
      FirebaseFirestore.instance.collection('restaurants');

  // restaurants markers collection reference
  final CollectionReference restaurantsMarkersCollection =
      FirebaseFirestore.instance.collection('restaurants_markers');

  final CollectionReference ingredientsCollection =
      FirebaseFirestore.instance.collection('ingredients');

  // ----------------- User -----------------
  // add or update user data
  Future addOrUpdateUserData(String uid, String name, bool isAdmin) async {
    try {
      await usersCollection.doc(uid).set({
        'name': name,
        'isAdmin': isAdmin,
      });
      return true;
    } catch (e) {
      print(e.toString());
      //TODO: need to handle an error on auth
      return null;
    }
  }

  Future<bool> isAdmin() async {
    User? user = _auth.currentUser;
    try {
      final DocumentSnapshot doc = await usersCollection.doc(user!.uid).get();
      return doc.get('isAdmin') ?? false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // ----------------- Search Restaurants -----------------

  Future<List<Map<String, dynamic>>> getAllRestaurants() async {
    try {
      final QuerySnapshot result = await restaurantsCollection.get();
      return result.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getRestaurantsbyLocation(
      String location) async {
    try {
      final QuerySnapshot result = await restaurantsCollection
          .where('location', isEqualTo: location)
          .get();
      return result.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
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
      return result.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // ----------------- My Restaurant -----------------
  // add or update a restaurant application
  Future addOrUpdateRestaurantApplicationData(
      String name,
      String phone,
      String location,
      String electricityUrl,
      String gasUrl,
      int numberOfSeats,
      double co2EmissionEstimate,
      String waterUrl) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsApplicationsCollection.doc(user!.uid).set({
        'name': name,
        'phone': phone,
        'location': location,
        'electricityUrl': electricityUrl,
        'gasUrl': gasUrl,
        'numberOfSeats': numberOfSeats,
        'co2EmissionEstimate': co2EmissionEstimate,
        'waterUrl': waterUrl,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //upload files to firebase storage
  Future<String?> uploadFile(Uint8List fileBytes, String fileName) async {
    try {
      final storageRef = _storage.ref().child('uploads/$fileName');
      final metadata = SettableMetadata(contentType: 'application/pdf');
      await storageRef.putData(fileBytes, metadata);
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Failed to upload file: $e');
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

  // add a dish
  Future addDishToRestaurant(
      String name, String description, double price) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsCollection.doc(user!.uid).collection('dishes').add({
        'name': name,
        'description': description,
        'price': price,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Ingredient>> getAllIngredients() async {
    try {
      final QuerySnapshot doc = await ingredientsCollection.get();
      return doc.docs.map((doc) {
        return Ingredient(
          name: doc.get('name') ?? '',
          grams: doc.get('grams') ?? 0,
          co2: doc.get('co2') ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
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
          co2EmissionEstimate: doc.get('co2EmissionEstimate') ?? 0,
          electricityPdfUrl: doc.get('electricityUrl') ?? '',
          gasPdfUrl: doc.get('gasUrl') ?? '',
          waterPdfUrl: doc.get('waterUrl') ?? '',
          numberOfSeats: doc.get('numberOfSeats') ?? 0,
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

  List<Ingredient> _ingredientsListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Ingredient(
          name: doc.get('name') ?? '',
          grams: doc.get('grams') ?? 0,
          co2: doc.get('co2') ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Stream<List<Ingredient>> get ingredients {
    try {
      return ingredientsCollection
          .snapshots()
          .map(_ingredientsListFromSnapshot);
    } catch (e) {
      print(e.toString());
      return Stream.empty();
    }
  }

  Future addOrUpdateIngredient(String name, int co2, int grams) async {
    try {
      await ingredientsCollection.doc(name).set({
        'name': name,
        'grams': grams,
        'co2': co2,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future deleteIngredient(String name) async {
    try {
      await ingredientsCollection.doc(name).delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addRestaurantMarker(
      String uid, String name, String imageUrl, String locality) async {
    try {
      await restaurantsMarkersCollection.doc(uid).set({
        'name': name,
        'image': imageUrl,
        'locality': locality,
        'rating': 0,
        'co2': 0,
        'latitude': 0,
        'longitude': 0,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRestaurantsbyLocality(
      String locality) async {
    try {
      final QuerySnapshot result = await restaurantsMarkersCollection
          .where('locality', isGreaterThanOrEqualTo: locality)
          .get();
      return result.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
