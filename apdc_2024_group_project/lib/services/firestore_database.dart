import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:adc_group_project/services/models/favoriterestaurant.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:adc_group_project/services/models/reservation.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// firestore database service
class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Storage do Firebase

  // users collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // restaurants applications collection reference
  final CollectionReference restaurantsApplicationsCollection =
      FirebaseFirestore.instance.collection('restaurants_applications');

  // locations collection reference
  final CollectionReference locationsCollection =
      FirebaseFirestore.instance.collection('locations');

  // restaurants collection reference
  final CollectionReference restaurantsCollection =
      FirebaseFirestore.instance.collection('restaurants');

  // ingredients collection reference
  final CollectionReference ingredientsCollection =
      FirebaseFirestore.instance.collection('ingredients');

  // reservations collection reference
  final CollectionReference reservationsCollection =
      FirebaseFirestore.instance.collection('reservations');

  // support messages collection reference
  final CollectionReference supportMessagesCollection =
      FirebaseFirestore.instance.collection('support_messages');

  // promo codes collection reference
  final CollectionReference promoCodesCollection =
      FirebaseFirestore.instance.collection('promo_codes');
  //restaurant types collection reference
  final CollectionReference restaurantTypesCollection =
      FirebaseFirestore.instance.collection('restaurant_types');

  // subcollections variables
  // ignore: constant_identifier_names
  static const String DISHES_SUBCOLLECTION = "dishes";
  // ignore: constant_identifier_names
  static const String INGREDIENTS_SUBCOLLECTION = "ingredients";
  // ignore: constant_identifier_names
  static const String FAVORITES_SUBCOLLECTION = "favorites_restaurants";
  // ignore: constant_identifier_names
  static const String SETTINGS_SUBCOLLECTION = "settings";
  // ignore: constant_identifier_names
  static const String USER_PROMOS_SUBCOLLECTION = "user_promos";
  // ignore: constant_identifier_names
  static const String RESTAURANT_TYPES_SUBCOLLECTION = "restaurant_types";
  // ignore: constant_identifier_names
  static const String RESTAURANTS_SUBCOLLECTION = "restaurants";

  // documents variables
  // ignore: constant_identifier_names
  static const String NOTIFICATION_SETTINGS_DOCUMENT = "notification_settings";

  // shared preferences variables
  // ignore: constant_identifier_names
  static const String USER_NAME_PREF = 'userName';
  // ignore: constant_identifier_names
  static const String USER_EMAIL_PREF = 'userEmail';
  // ignore: constant_identifier_names
  static const String USER_IMAGE_PREF = 'profile_image';

  // ----------------- Sign Up -----------------
  // create or overwrite user data
  Future createOrOverwriteUserData(
      String uid, String name, bool isAdmin) async {
    try {
      await usersCollection.doc(uid).set({
        'name': name,
        'isAdmin': isAdmin,
        'emissions': 0,
        'deslocatEmissions': 0,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
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
  // get visible restaurants by location
  Future<List<Restaurant>> getRestaurantsbyLocation(String location) async {
    try {
      final QuerySnapshot result = await restaurantsCollection
          .where("location", isEqualTo: location)
          .where('visible', isEqualTo: true)
          .get();
      return result.docs
          .map((doc) => Restaurant(
                imageUrl: doc.get('imageUrl') ?? '',
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

  // get visible restaurants by name
  Future<List<Restaurant>> searchRestaurants(String search) async {
    String lowerSearch = search.toLowerCase();

    try {
      final QuerySnapshot result = await restaurantsCollection
          .orderBy('lowerCaseName')
          .where('visible', isEqualTo: true)
          .startAt({lowerSearch}).endAt({"$lowerSearch\uf8ff"}).get();
      return result.docs
          .map((doc) => Restaurant(
                imageUrl: doc.get('imageUrl') ?? '',
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

  Future<Restaurant> getRestaurantById(String restaurantId) async {
    try {
      final DocumentSnapshot doc =
          await restaurantsCollection.doc(restaurantId).get();
      return Restaurant(
        imageUrl: doc.get('imageUrl') ?? '',
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
      return Restaurant(
        imageUrl: '',
        id: '',
        name: '',
        phone: '',
        address: '',
        location: '',
        coordinates: '',
        co2EmissionEstimate: 0,
        seats: 0,
        visible: false,
        isOpen: [],
        time: [],
      );
    }
  }

  // ----------------- Locations -----------------

  Future incrementLocation(String location) async {
    final DocumentSnapshot doc = await locationsCollection.doc(location).get();
    if (doc.exists) {
      await locationsCollection.doc(location).set({
        'location': location,
        'count': FieldValue.increment(1),
      }, SetOptions(merge: true));
    } else {
      await locationsCollection.doc(location).set({
        'location': location,
        'count': 1,
      });
    }
  }

  Future decrementLocation(String location) async {
    final DocumentSnapshot doc = await locationsCollection.doc(location).get();
    if (doc.exists) {
      if (doc.get('count') > 1) {
        await locationsCollection.doc(location).set({
          'location': location,
          'count': FieldValue.increment(-1),
        }, SetOptions(merge: true));
      } else {
        await locationsCollection.doc(location).delete();
      }
    } else {
      return;
    }
  }

  Future getLocations() async {
    List<String> locations = [];
    try {
      final QuerySnapshot doc = await locationsCollection.get();
      for (var location in doc.docs) {
        locations.add(location.get('location') ?? '');
      }
      return locations;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // ----------------- No Restaurant (Application) -----------------
  // create or overwrite a restaurant application
  Future createOrOverwriteRestaurantApplicationData(
    String name,
    String phone,
    String address,
    String location,
    int seats,
    String coords,
    List<String> restaurantTypes,
  ) async {
    User? user = _auth.currentUser;
    try {
      final restaurantData = {
        'name': name,
        'phone': phone,
        'address': address,
        'location': location,
        'seats': seats,
        'coordinates': coords,
      };

      await restaurantsApplicationsCollection
          .doc(user!.uid)
          .set(restaurantData);

      CollectionReference typesCollection = restaurantsApplicationsCollection
          .doc(user.uid)
          .collection(RESTAURANT_TYPES_SUBCOLLECTION);
      for (String type in restaurantTypes) {
        await typesCollection.doc(type).set({});
      }
      return true;
    } catch (e) {
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
        imageUrl: doc.get('imageUrl') ?? '',
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
  Future updateRestaurantData(String name, String phone, List<bool> isOpen,
      List<String> time, String? url) async {
    User? user = _auth.currentUser;
    try {
      await restaurantsCollection.doc(user!.uid).update({
        'name': name,
        'lowerCaseName': name.toLowerCase(),
        'phone': phone,
        'isOpen': isOpen,
        'time': time,
        'imageUrl': url,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // get restaurant image url by restaurantId
  Future getRestaurantImageUrlByRestaurantId(String restaurantId) async {
    try {
      return await StorageService().getRestaurantImageUrl(restaurantId);
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
      return StorageService().getRestaurantImageUrl(user.uid);
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
      return StorageService().getRestaurantImageUrl(user.uid);
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
  // get all ingredients
  Future<List<Ingredient>> getAllIngredients() async {
    try {
      final QuerySnapshot doc = await ingredientsCollection.get();
      return doc.docs.map((doc) {
        return Ingredient(
          name: doc.id,
          grams: doc.get('grams').toInt() ?? 0,
          co2: doc.get('co2').toInt() ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // create dish mobile
  Future createDishMobile(String name, String description, double price,
      int co2, List ingredients, String imagePath) async {
    User? user = _auth.currentUser;
    try {
      CollectionReference<Map<String, dynamic>> path =
          restaurantsCollection.doc(user!.uid).collection(DISHES_SUBCOLLECTION);

      final String dishId = path.doc().id;
      await path.doc(dishId).set({
        'name': name,
        'description': description,
        'price': price,
        'co2': co2,
        'visible': false,
      });

      ingredients.forEach((ingredient) async {
        await path
            .doc(dishId)
            .collection(INGREDIENTS_SUBCOLLECTION)
            .doc(ingredient.name)
            .set({
          'grams': ingredient.grams,
          'co2': ingredient.co2,
        });
      });

      await StorageService().uploadDishImageMobile(user.uid, dishId, imagePath);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // create dish web
  Future createDishWeb(String name, String description, double price, int co2,
      List ingredients, Uint8List imageBytes, String imageExtension) async {
    User? user = _auth.currentUser;
    try {
      CollectionReference<Map<String, dynamic>> path =
          restaurantsCollection.doc(user!.uid).collection(DISHES_SUBCOLLECTION);

      final String dishId = path.doc().id;
      await path.doc(dishId).set({
        'name': name,
        'description': description,
        'price': price,
        'co2': co2,
        'visible': false,
      });

      ingredients.forEach((ingredient) async {
        await path
            .doc(dishId)
            .collection(INGREDIENTS_SUBCOLLECTION)
            .doc(ingredient.name)
            .set({
          'grams': ingredient.grams,
          'co2': ingredient.co2,
        });
      });

      await StorageService()
          .uploadDishImageWeb(user.uid, dishId, imageBytes, imageExtension);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // get dishes from snapshot
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

  // get all restaurant dishes
  Future<List<Dish>> getAllRestaurantDishes(String restaurantId) async {
    try {
      final QuerySnapshot snapshot = await restaurantsCollection
          .doc(restaurantId)
          .collection(DISHES_SUBCOLLECTION)
          .where('visible', isEqualTo: true)
          .get();
      return _dishesListFromSnapshot(snapshot);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // get dishes stream
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
      return const Stream.empty();
    }
  }

  // delete dish
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
        for (DocumentSnapshot ingredient in snapshot.docs) {
          ingredient.reference.delete();
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

  // update dish visibility
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

  // get dish image url
  Future getDishImageUrl(String dishId) async {
    User? user = _auth.currentUser;
    try {
      return await StorageService().getDishImageUrl(user!.uid, dishId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // get dish image url
  Future getDishImageUrlUsers(String restaurantUid, String dishId) async {
    try {
      return await StorageService().getDishImageUrl(restaurantUid, dishId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // get dish list of ingredients
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
          name: doc.id,
          grams: doc.get('grams').toInt() ?? 0,
          co2: doc.get('co2').toInt() ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // is restaurant visible
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
  // update restaurant visibility
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

  // restaurant has visible dishes
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

  //delete all restaurant data
  Future deleteRestaurant() async {
    User? user = _auth.currentUser;
    try {
      //get restaurant dishes
      QuerySnapshot dishesSnapshot = await restaurantsCollection
          .doc(user!.uid)
          .collection(DISHES_SUBCOLLECTION)
          .get();
      //delete all dishes
      for (DocumentSnapshot doc in dishesSnapshot.docs) {
        await deleteDish(doc.id);
      }
      //get restaurant reservations
      QuerySnapshot reservationsSnapshot = await reservationsCollection
          .where('restaurantId', isEqualTo: user.uid)
          .get();
      //delete all reservations
      for (DocumentSnapshot doc in reservationsSnapshot.docs) {
        await doc.reference.delete();
      }
      //get restaurant types docs
      QuerySnapshot typesSnapshot = await restaurantTypesCollection.get();
      //go through all restaurant types and delete the restaurantid from the restaurants subcollection
      for (DocumentSnapshot doc in typesSnapshot.docs) {
        await restaurantTypesCollection
            .doc(doc.id)
            .collection(RESTAURANTS_SUBCOLLECTION)
            .doc(user.uid)
            .delete();
      }
      // delete restaurant doc
      await restaurantsCollection.doc(user.uid).delete();
      // delete restaurant documents in storage
      StorageService().deleteRestaurant(user.uid);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // ----------------- Favorites -----------------
  // get favorite restaurants
  Future<List<FavoriteRestaurant>> getFavoriteRestaurants(
      {DocumentSnapshot? lastDocument, int pageSize = 10}) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return [];
    }

    Query query = usersCollection
        .doc(user.uid)
        .collection(FAVORITES_SUBCOLLECTION)
        .limit(pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    QuerySnapshot favoriteSnapshot = await query.get();
    if (favoriteSnapshot.docs.isEmpty) {
      return [];
    }

    List<FavoriteRestaurant> newRestaurants = [];
    for (var doc in favoriteSnapshot.docs) {
      DocumentSnapshot restaurantDoc =
          await restaurantsCollection.doc(doc.id).get();
      newRestaurants.add(FavoriteRestaurant.fromFirestore(restaurantDoc));
    }

    return newRestaurants;
  }

  // remove favorit restaurant
  Future<void> removeFavoriteRestaurant(String restaurantId) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return;
    }

    DocumentReference userDoc = usersCollection
        .doc(user.uid)
        .collection(FAVORITES_SUBCOLLECTION)
        .doc(restaurantId);

    await userDoc.delete();
  }

//  check if favorite
  Future<bool> checkIfFavorite(String restaurantId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await usersCollection
          .doc(user.uid)
          .collection(FAVORITES_SUBCOLLECTION)
          .doc(restaurantId)
          .get();
      return userDoc.exists;
    }
    return false;
  }

// toggle favorite
  Future<void> toggleFavorite(String restaurantId, bool isFavorite) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference favoriteRef = usersCollection
          .doc(user.uid)
          .collection(FAVORITES_SUBCOLLECTION)
          .doc(restaurantId);
      if (isFavorite) {
        await favoriteRef.delete();
      } else {
        await favoriteRef.set(<String, dynamic>{});
      }
    }
  }

  // ----------------- Help and Support -----------------
  Future<void> sendEmailAndAddToFirestore(String message) async {
    final User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      await supportMessagesCollection.doc().set({
        'userId': userId,
        'email': user.email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception('Usuário não autenticado.');
    }
  }

  // ----------------- Profile -----------------
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<Map<String, String>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(USER_NAME_PREF) ?? '';
    String email = prefs.getString(USER_EMAIL_PREF) ?? '';

    if (name.isEmpty || email.isEmpty) {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await usersCollection.doc(user.uid).get();
        if (userData.exists) {
          name = userData['name'] ?? '';
          email = userData['email'] ?? user.email!;
          prefs.setString(USER_NAME_PREF, name);
          prefs.setString(USER_EMAIL_PREF, email);
        }
      }
    }
    return {'name': name, 'email': email};
  }

  Future<List<String>> getUserEmissions() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userData = await usersCollection.doc(user.uid).get();
      if (userData.exists) {
        return [
          (userData['emissions'] ?? 0).toString(),
          (userData['deslocatEmissions'] ?? 0).toString(),
        ];
      }
    }
    return ['0', '0'];
  }

  Future<void> updateUserData(String name, String email) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await usersCollection.doc(user.uid).update({
        'name': name,
        'email': email,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(USER_NAME_PREF, name);
      prefs.setString(USER_EMAIL_PREF, email);
    } else {
      throw Exception('Usuário não autenticado.');
    }
  }

  Future<Uint8List?> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imageBase64 = prefs.getString(USER_IMAGE_PREF);
    if (imageBase64 != null) {
      return base64Decode(imageBase64);
    }
    return null;
  }

  Future<String?> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString(USER_NAME_PREF);

    if (name == null) {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await usersCollection.doc(user.uid).get();
        name = userData['name'];
        await prefs.setString(USER_NAME_PREF, name!);
      }
    }

    return name;
  }

  // ----------------- User Settings -----------------
  Future<DocumentSnapshot> getUserSettings(String userId) async {
    try {
      return await usersCollection
          .doc(userId)
          .collection(SETTINGS_SUBCOLLECTION)
          .doc(NOTIFICATION_SETTINGS_DOCUMENT)
          .get();
    } catch (e) {
      throw Exception("Error loading user settings: $e");
    }
  }

  Future<void> updateUserSettings(
      String userId, bool specialOffers, bool reservationInfo) async {
    try {
      await usersCollection
          .doc(userId)
          .collection(SETTINGS_SUBCOLLECTION)
          .doc(NOTIFICATION_SETTINGS_DOCUMENT)
          .set({
        'specialOffers': specialOffers,
        'reservationInfo': reservationInfo,
      });
    } catch (e) {
      throw Exception("Error updating user settings: $e");
    }
  }

  Future<void> deleteUserNotificationSettings(String userId) async {
    try {
      await usersCollection
          .doc(userId)
          .collection(SETTINGS_SUBCOLLECTION)
          .doc(NOTIFICATION_SETTINGS_DOCUMENT)
          .delete();
    } catch (e) {
      print("Error deleting user notification settings: $e");
      rethrow;
    }
  }

  Future<void> deleteUserPromos(String userId) async {
    try {
      QuerySnapshot promosSnapshot = await usersCollection
          .doc(userId)
          .collection(USER_PROMOS_SUBCOLLECTION)
          .get();

      for (DocumentSnapshot doc in promosSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print("Error deleting user promos: $e");
      rethrow;
    }
  }

  Future<void> deleteUserFavoriteRestaurants(String userId) async {
    try {
      QuerySnapshot favoritesSnapshot = await usersCollection
          .doc(userId)
          .collection(FAVORITES_SUBCOLLECTION)
          .get();

      for (DocumentSnapshot doc in favoritesSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print("Error deleting user favorite restaurants: $e");
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      // user has restaurant
      if (await hasRestaurant() == true) {
        await deleteRestaurant();
      }
      await usersCollection.doc(userId).delete();
    } catch (e) {
      print("Error deleting user document: $e");
      rethrow;
    }
  }

  // ----------------- User Promos -----------------
  Future<DocumentSnapshot> getPromoCode(String promoCode) async {
    try {
      return await promoCodesCollection.doc(promoCode).get();
    } catch (e) {
      print("Error getting promo code: $e");
      rethrow;
    }
  }

  Future<void> redeemPromoCode(String promoCode, String reward) async {
    try {
      // Obter o usuário atualmente autenticado
      User? user = _auth.currentUser;

      if (user != null) {
        // Referência à coleção de promoções do usuário
        DocumentReference userPromoDoc = usersCollection
            .doc(user.uid)
            .collection(USER_PROMOS_SUBCOLLECTION)
            .doc(promoCode);

        // Adicionar a promoção à coleção de promoções do usuário
        await userPromoDoc.set({
          'reward': reward,
          'redeemed_at': Timestamp.now(),
        });
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      print("Error redeeming promo code: $e");
      rethrow; // Você pode optar por lidar com o erro aqui ou propagá-lo para cima
    }
  }

  // ----------------- BackOffice -----------------
  // restaurants applications list from snapshot
  List<RestaurantApplication> _restaurantsApplicationsListFromSnapshot(
      QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        // Referência para a subcoleção restaurant_types
        CollectionReference typesCollection =
            doc.reference.collection(RESTAURANT_TYPES_SUBCOLLECTION);

        // Obter os tipos de restaurante
        List<String> restaurantTypes = [];
        typesCollection.get().then((typesSnapshot) {
          typesSnapshot.docs.forEach((typeDoc) {
            restaurantTypes.add(typeDoc.id);
          });
        });

        return RestaurantApplication(
          uid: doc.id,
          name: doc.get('name') ?? '',
          phone: doc.get('phone') ?? '',
          location: doc.get('location') ?? '',
          address: doc.get('address') ?? '',
          seats: doc.get('seats').toInt() ?? 0,
          coordinates: doc.get('coordinates') ?? '',
          types: restaurantTypes, // Lista de tipos de restaurante
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // get restaurants applications list stream
  Stream<List<RestaurantApplication>> get restaurantsApplications {
    try {
      return restaurantsApplicationsCollection
          .snapshots()
          .map(_restaurantsApplicationsListFromSnapshot);
    } catch (e) {
      debugPrint(e.toString());
      return const Stream.empty();
    }
  }

  // delete restaurant application
  Future deleteRestaurantApplication(String uid) async {
    try {
      await deleteRestaurantApplicationSubcollection(uid);
      await restaurantsApplicationsCollection.doc(uid).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //delete restaurant application subcollection

  Future deleteRestaurantApplicationSubcollection(String uid) async {
    try {
      CollectionReference typesCollection = restaurantsApplicationsCollection
          .doc(uid)
          .collection(RESTAURANT_TYPES_SUBCOLLECTION);
      QuerySnapshot typesSnapshot = await typesCollection.get();
      for (DocumentSnapshot doc in typesSnapshot.docs) {
        await doc.reference.delete();
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // create or overwrite restaurant data
  Future createOrOverwriteRestaurantData(
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
        'imageUrl': '',
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // ingredients list from snapshot
  List<Ingredient> _ingredientsListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Ingredient(
          name: doc.id,
          grams: doc.get('grams').toInt() ?? 0,
          co2: doc.get('co2').toInt() ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // get ingredients stream
  Stream<List<Ingredient>> get ingredients {
    try {
      return ingredientsCollection
          .snapshots()
          .map(_ingredientsListFromSnapshot);
    } catch (e) {
      debugPrint(e.toString());
      return const Stream.empty();
    }
  }

  // create or overwrite ingredient
  Future createOrOverwriteIngredient(String name, int co2, int grams) async {
    try {
      await ingredientsCollection.doc(name).set({
        'grams': grams,
        'co2': co2,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // delete ingredient
  Future deleteIngredient(String name) async {
    try {
      await ingredientsCollection.doc(name).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // promocode

  Future<List<DocumentSnapshot>> loadPromoCodes({
    required DocumentSnapshot? lastDocument,
    required int pageSize,
  }) async {
    Query query = promoCodesCollection.limit(pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    try {
      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error loading promo codes: $e");
      rethrow;
    }
  }

  Future<void> deletePromoCode(String promoCodeId) async {
    try {
      await promoCodesCollection.doc(promoCodeId).delete();
    } catch (e) {
      print("Error deleting promo code: $e");
      rethrow;
    }
  }

  Future addRestaurantReservationsData(
      String restaurantID,
      String restaurantName,
      List<String> order,
      double cost,
      double averageEmission,
      DateTime start) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await reservationsCollection.doc().set({
          'userId': user.uid,
          'userName': await loadUserName(),
          'restaurantId': restaurantID,
          'restaurantName': restaurantName,
          'order': order,
          'cost': cost,
          'averageEmissions': averageEmission,
          'start': start,
          'end': start.add(const Duration(hours: 1)),
        });
      } else {
        throw Exception("User not logged in");
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Reservation>> getRestaurantReservations(
      String restaurantID) async {
    try {
      final QuerySnapshot snapshot = await reservationsCollection
          .where('restaurantId', isEqualTo: restaurantID)
          .get();
      return reservationsListFromSnapshot(snapshot);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Reservation>> getUserReservations() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        final QuerySnapshot snapshot = await reservationsCollection
            .where('userId', isEqualTo: user.uid)
            .get();
        return reservationsListFromSnapshot(snapshot);
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  List<Reservation> reservationsListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Reservation(
          userID: doc.get('userId') ?? '',
          userName: doc.get('userName') ?? '',
          restaurantID: doc.get('restaurantId') ?? '',
          restaurantName: doc.get('restaurantName') ?? '',
          order: doc.get('order').map<String>((e) => e as String).toList(),
          cost: doc.get('cost').toDouble() ?? 0,
          averageEmissions: doc.get('averageEmissions').toDouble() ?? 0,
          start: doc.get('start').toDate() ?? DateTime.now(),
          end: doc.get('end').toDate() ?? DateTime.now(),
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  //-----------------RestaurantTypes-----------------

  Future<void> addRestaurantType(String typeName) async {
    try {
      await restaurantTypesCollection.doc(typeName).set({});
    } catch (e) {
      print("Error adding restaurant type: $e");
      rethrow;
    }
  }

  Future<bool> restaurantTypeExists(String typeName) async {
    try {
      return await restaurantTypesCollection.doc(typeName).get().then((doc) {
        return doc.exists;
      });
    } catch (e) {
      print("Error getting restaurant type: $e");
      rethrow;
    }
  }

  Future<List<DocumentSnapshot>> getRestaurantTypes() async {
    try {
      QuerySnapshot querySnapshot = await restaurantTypesCollection.get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error getting restaurant types: $e");
      rethrow;
    }
  }

  Future<void> deleteRestaurantType(String typeId) async {
    try {
      await restaurantTypesCollection.doc(typeId).delete();
    } catch (e) {
      print("Error deleting restaurant type: $e");
      rethrow;
    }
  }

  Future<void> addRestaurantIdToTypes(
      List<String> typeNames, String restaurantId) async {
    try {
      for (String typeName in typeNames) {
        await restaurantTypesCollection
            .doc(typeName)
            .collection('restaurants')
            .doc(restaurantId)
            .set({});
      }
    } catch (e) {
      print("Error adding restaurant ID to types: $e");
      rethrow;
    }
  }

  Future<List<Restaurant>> getRestaurantsByType(String type) async {
    List<Restaurant> restaurants = [];
    try {
          final subCollection =
              restaurantTypesCollection.doc(type).collection('restaurants');
          final snapshot = await subCollection.get();
          for (final doc in snapshot.docs) {
            final restaurantId = doc.id;
            final restaurantDoc =
                await restaurantsCollection.doc(restaurantId).get();
            if (restaurantDoc.exists && restaurantDoc.get('visible') == true) {
              restaurants.add(Restaurant.fromFirestore(restaurantDoc));
            }
          }
    } catch (e) {
      print('Error fetching restaurants by type: $e');
    }
    return restaurants;
  }

  // ----------------- Emissions -----------------

  Future<void> updateUserEmissions(
    double emissions,
  ) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await usersCollection.doc(user.uid).update({
          'emissions': FieldValue.increment(emissions),
        });
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      print("Error adding emission data: $e");
      rethrow;
    }
  }

  Future<void> updateUserDeslocatEmissions(
    double emissions,
  ) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await usersCollection.doc(user.uid).update({
          'deslocatEmissions': FieldValue.increment(emissions),
        });
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      print("Error adding emission data: $e");
      rethrow;
    }
  }

  Future<void> addPromoCode(String promoCode, int reward) async {
    try {
      await promoCodesCollection.doc(promoCode).set({
        'reward': reward,
      });
    } catch (e) {
      print("Error adding promo code: $e");
      rethrow;
    }
  }
}
