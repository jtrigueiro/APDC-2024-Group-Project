import 'dart:async';
import 'dart:typed_data';

import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// firestore database service
class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // ingredients collection reference
  final CollectionReference ingredientsCollection =
      FirebaseFirestore.instance.collection('ingredients');

  // subcollections variables
  static const String DISHES_SUBCOLLECTION = "dishes";
  static const String INGREDIENTS_SUBCOLLECTION = "ingredients";

  // ----------------- Sign Up -----------------
  // add or update user data
  Future addOrUpdateUserData(String uid, String name, bool isAdmin) async {
    try {
      await usersCollection.doc(uid).set({
        'name': name,
        'isAdmin': isAdmin,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      //TODO: need to handle an error on auth
      return null;
    }
  }

  // ----------------- Home Screen Router -----------------
  Future<bool> isAdmin() async {
    User? user = _auth.currentUser;
    try {
      final DocumentSnapshot doc = await usersCollection.doc(user!.uid).get();
      return doc.get('isAdmin') ?? false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // ----------------- Search Restaurants -----------------

  Future<List<Restaurant>> getRestaurantsbyLocation(String location) async {
    try {
      final QuerySnapshot result = await restaurantsCollection
          .where("location", isEqualTo: location)
          //.where('visible', isEqualTo: true)
          .get();
      return result.docs
          .map((doc) => Restaurant(
                id: doc.id,
                name: doc.get('name') ?? '',
                phone: doc.get('phone') ?? '',
                address: doc.get('address') ?? '',
                location: doc.get('location') ?? '',
                coordinates: doc.get('coordinates') ?? '',
                co2EmissionEstimate:
                    doc.get('co2EmissionEstimate').toDouble() ?? 0,
                seats: doc.get('seats').toInt() ?? 0,
                visible: doc.get('visible') ?? false,
                isOpen: doc.get('isOpen').map<bool>((e) => e as bool).toList(),
                time: doc.get('time').map<String>((e) => e as String).toList(),
              ))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Restaurant>> searchRestaurants(String search) async {
    String lowerSearch = search.toLowerCase();

    try {
      final QuerySnapshot result = await restaurantsCollection
          .orderBy('lowerCaseName')
          //.where('visible', isEqualTo: true)
          .startAt({lowerSearch}).endAt({"$lowerSearch\uf8ff"}).get();
      return result.docs
          .map((doc) => Restaurant(
                id: doc.id,
                name: doc.get('name') ?? '',
                phone: doc.get('phone') ?? '',
                address: doc.get('address') ?? '',
                location: doc.get('location') ?? '',
                coordinates: doc.get('coordinates') ?? '',
                co2EmissionEstimate:
                    doc.get('co2EmissionEstimate').toDouble() ?? 0,
                seats: doc.get('seats').toInt() ?? 0,
                visible: doc.get('visible') ?? false,
                isOpen: doc.get('isOpen').map<bool>((e) => e as bool).toList(),
                time: doc.get('time').map<String>((e) => e as String).toList(),
              ))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // ----------------- No Restaurant (Application) -----------------
  // add or update a restaurant application
  Future addOrUpdateRestaurantApplicationData(String name, String phone,
      String address, String location, int seats, String coords) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsApplicationsCollection.doc(user!.uid).set({
        'name': name,
        'phone': phone,
        'address': address,
        'location': location,
        'seats': seats,
        'coordinates': coords,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint('Failed to upload file: $e');
      return null;
    }
  }

  // ----------------- My Restaurant Profile -----------------
  // get restaurant data
  Future getRestaurantData() async {
    User? user = _auth.currentUser;
    try {
      final DocumentSnapshot doc =
          await restaurantsCollection.doc(user!.uid).get();
      return Restaurant(
        id: doc.id,
        name: doc.get('name') ?? '',
        phone: doc.get('phone') ?? '',
        address: doc.get('address') ?? '',
        location: doc.get('location') ?? '',
        coordinates: doc.get('coordinates') ?? '',
        co2EmissionEstimate: doc.get('co2EmissionEstimate').toDouble() ?? 0,
        seats: doc.get('seats').toInt() ?? 0,
        visible: doc.get('visible') ?? false,
        isOpen: doc.get('isOpen').map<bool>((e) => e as bool).toList(),
        time: doc.get('time').map<String>((e) => e as String).toList(),
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // update restaurant data
  Future updateRestaurantData(
      String name, String phone, List<bool> isOpen, List<String> time) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsCollection.doc(user!.uid).update({
        'name': name,
        'lowerCaseName': name.toLowerCase(),
        'phone': phone,
        'isOpen': isOpen,
        'time': time
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // get restaurant image url
  Future getRestaurantImageUrl() async {
    User? user = _auth.currentUser;
    try {
      return await StorageService().getRestaurantImageUrl(user!.uid);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // upload restaurant image mobile
  Future uploadRestaurantImageMobile(String imagePath) async {
    User? user = _auth.currentUser;
    try {
      await StorageService().uploadRestaurantImageMobile(user!.uid, imagePath);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // upload restaurant image web
  Future uploadRestaurantImageWeb(
      Uint8List imageBytes, String imageExtension) async {
    User? user = _auth.currentUser;
    try {
      await StorageService()
          .uploadRestaurantImageWeb(user!.uid, imageBytes, imageExtension);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // ----------------- My Restaurant Screen Router -----------------
  // has a restaurant application
  Future hasRestaurantApplication() async {
    User? user = _auth.currentUser;
    try {
      final DocumentSnapshot doc =
          await restaurantsApplicationsCollection.doc(user!.uid).get();
      return doc.exists;
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return null;
    }
  }

  // ----------------- My Restaurant Dishes -----------------
  Future<List<Ingredient>> getAllIngredients() async {
    try {
      final QuerySnapshot doc = await ingredientsCollection.get();
      return doc.docs.map((doc) {
        return Ingredient(
          name: doc.get('name') ?? '',
          grams: doc.get('grams').toInt() ?? 0,
          co2: doc.get('co2').toInt() ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future addOrUpdateDishMobile(String name, String description, double price,
      int co2, List ingredients, String imagePath) async {
    User? user = _auth.currentUser;
    try {
      CollectionReference<Map<String, dynamic>> path =
          restaurantsCollection.doc(user!.uid).collection(DISHES_SUBCOLLECTION);

      var result = await path.add({
        'name': name,
        'description': description,
        'price': price,
        'co2': co2,
        'visible': false,
      });

      ingredients.forEach((ingredient) async {
        await path.doc(result.id).collection(INGREDIENTS_SUBCOLLECTION).add({
          'name': ingredient.name,
          'grams': ingredient.grams,
          'co2': ingredient.co2,
        });
      });

      await StorageService()
          .uploadDishImageMobile(user.uid, result.id, imagePath);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future addOrUpdateDishWeb(
      String name,
      String description,
      double price,
      int co2,
      List ingredients,
      Uint8List imageBytes,
      String imageExtension) async {
    User? user = _auth.currentUser;
    try {
      CollectionReference<Map<String, dynamic>> path =
          restaurantsCollection.doc(user!.uid).collection(DISHES_SUBCOLLECTION);

      var result = await path.add({
        'name': name,
        'description': description,
        'price': price,
        'co2': co2,
        'visible': false,
      });

      ingredients.forEach((ingredient) async {
        await path.doc(result.id).collection(INGREDIENTS_SUBCOLLECTION).add({
          'name': ingredient.name,
          'grams': ingredient.grams,
          'co2': ingredient.co2,
        });
      });

      await StorageService()
          .uploadDishImageWeb(user.uid, result.id, imageBytes, imageExtension);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  List<Dish> _dishesListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Dish(
          id: doc.id,
          name: doc.get('name') ?? '',
          description: doc.get('description') ?? '',
          co2: doc.get('co2').toInt() ?? 0,
          price: doc.get('price').toDouble() ?? 0,
          visible: doc.get('visible') ?? false,
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Stream<List<Dish>> get dishes {
    try {
      User? user = _auth.currentUser;
      return restaurantsCollection
          .doc(user!.uid)
          .collection(DISHES_SUBCOLLECTION)
          .snapshots()
          .map(_dishesListFromSnapshot);
    } catch (e) {
      debugPrint(e.toString());
      return Stream.empty();
    }
  }

  Future deleteDish(String dishId) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsCollection
          .doc(user!.uid)
          .collection(DISHES_SUBCOLLECTION)
          .doc(dishId)
          .collection(INGREDIENTS_SUBCOLLECTION)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });

      await restaurantsCollection
          .doc(user.uid)
          .collection(DISHES_SUBCOLLECTION)
          .doc(dishId)
          .delete();

      await StorageService().deleteDishImage(user.uid, dishId);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future updateDishVisibility(String dishId, bool visibility) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsCollection
          .doc(user!.uid)
          .collection(DISHES_SUBCOLLECTION)
          .doc(dishId)
          .update({'visible': !visibility});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future getDishImageUrl(String dishId) async {
    User? user = _auth.currentUser;
    try {
      return await StorageService().getDishImageUrl(user!.uid, dishId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Ingredient>> getDishListOfIngredients(String dishId) async {
    User? user = _auth.currentUser;
    try {
      final QuerySnapshot doc = await restaurantsCollection
          .doc(user!.uid)
          .collection(DISHES_SUBCOLLECTION)
          .doc(dishId)
          .collection(INGREDIENTS_SUBCOLLECTION)
          .get();
      return doc.docs.map((doc) {
        return Ingredient(
          name: doc.get('name') ?? '',
          grams: doc.get('grams').toInt() ?? 0,
          co2: doc.get('co2').toInt() ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future isRestaurantVisible() async {
    User? user = _auth.currentUser;
    try {
      final DocumentSnapshot doc =
          await restaurantsCollection.doc(user!.uid).get();
      return doc.get('visible') ?? false;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // ----------------- My Restaurant Settings -----------------
  Future updateRestaurantVisibility(bool visibility) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsCollection
          .doc(user!.uid)
          .update({'visible': visibility});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future hasVisibleDishes() async {
    User? user = _auth.currentUser;
    try {
      final QuerySnapshot doc = await restaurantsCollection
          .doc(user!.uid)
          .collection(DISHES_SUBCOLLECTION)
          .where('visible', isEqualTo: true)
          .get();
      return doc.docs.isNotEmpty;
    } catch (e) {
      debugPrint(e.toString());
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
          uid: doc.id,
          name: doc.get('name') ?? '',
          phone: doc.get('phone') ?? '',
          location: doc.get('location') ?? '',
          address: doc.get('address') ?? '',
          seats: doc.get('seats').toInt() ?? 0,
          coordinates: doc.get('coordinates') ?? '',
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return Stream.empty();
    }
  }

  // delete restaurant application
  Future deleteRestaurantApplication(String uid) async {
    try {
      await restaurantsApplicationsCollection.doc(uid).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // add or update restaurant data
  Future addOrUpdateRestaurantData(
      String uid,
      String name,
      String phone,
      String address,
      String location,
      String coords,
      double co2EmissionEstimate,
      int seats) async {
    try {
      await restaurantsCollection.doc(uid).set({
        'name': name,
        'lowerCaseName': name.toLowerCase(),
        'phone': phone,
        'address': address,
        'location': location,
        'coordinates': coords,
        'co2EmissionEstimate': co2EmissionEstimate,
        'seats': seats,
        'visible': false,
        'isOpen': [false, false, false, false, false, false, false],
        'time': [
          "0:0-0:0",
          "0:0-0:0",
          "0:0-0:0",
          "0:0-0:0",
          "0:0-0:0",
          "0:0-0:0",
          "0:0-0:0",
        ],
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  List<Ingredient> _ingredientsListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Ingredient(
          name: doc.get('name') ?? '',
          grams: doc.get('grams').toInt() ?? 0,
          co2: doc.get('co2').toInt() ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Stream<List<Ingredient>> get ingredients {
    try {
      return ingredientsCollection
          .snapshots()
          .map(_ingredientsListFromSnapshot);
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return null;
    }
  }

  Future deleteIngredient(String name) async {
    try {
      await ingredientsCollection.doc(name).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
