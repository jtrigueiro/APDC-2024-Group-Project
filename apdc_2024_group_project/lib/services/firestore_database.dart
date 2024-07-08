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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// firestore database service
class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Storage do Firebase
  final FirebaseStorage _storage = FirebaseStorage
      .instance; // TODO: this should not be here, do not mix db classes - jose to wilker

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
        'userId': uid,
        'name': name,
        'isAdmin': isAdmin,
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
        'restaurantId': user!.uid,
        'name': name,
        'phone': phone,
        'address': address,
        'location': location,
        'seats': seats,
        'coordinates': coords,
      };
      print("Restaurant Data: $restaurantData");

      await restaurantsApplicationsCollection.doc(user.uid).set(restaurantData);

      CollectionReference typesCollection = restaurantsApplicationsCollection
          .doc(user.uid)
          .collection('restaurant_types');
      for (String type in restaurantTypes) {
        final typeData = {'name': type};
        print("Type Data: $typeData");
        await typesCollection.doc(type).set(typeData);
      }
      return true;
    } catch (e) {
      print("Error creating or overwriting restaurant application data: $e");
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
  // get all ingredients
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

  // create dish mobile
  Future createDishMobile(String name, String description, double price,
      int co2, List ingredients, String imagePath) async {
    User? user = _auth.currentUser;
    try {
      CollectionReference<Map<String, dynamic>> path =
          restaurantsCollection.doc(user!.uid).collection(DISHES_SUBCOLLECTION);

      final String dishId = path.doc().id;
      await path.doc(dishId).set({
        'dishId': dishId,
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
          'name': ingredient.name,
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
        'dishId': dishId,
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
          'name': ingredient.name,
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
  Future<List<Dish>> getAllRestaurantDishes(String restaurantUid) async {
    try {
      final QuerySnapshot snapshot = await restaurantsCollection
          .doc(restaurantUid)
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
      String imageUrl = await _storage
          .ref()
          .child('restaurants/$restaurantUid/dishes/$dishId')
          .getDownloadURL();
      return imageUrl;
    } catch (e) {
      debugPrint("Error getting dish image URL: $e");
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
      String messageId = supportMessagesCollection.doc().id;

      await supportMessagesCollection.doc(messageId).set({
        'messageId': messageId,
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
      throw e; // Você pode escolher lidar com o erro aqui ou propagá-lo para cima
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
      throw e; // Você pode escolher lidar com o erro aqui ou propagá-lo para cima
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
      throw e; // Você pode escolher lidar com o erro aqui ou propagá-lo para cima
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await usersCollection.doc(userId).delete();
    } catch (e) {
      print("Error deleting user document: $e");
      throw e; // Você pode escolher lidar com o erro aqui ou propagá-lo para cima
    }
  }

  // ----------------- User Promos -----------------
  Future<DocumentSnapshot> getPromoCode(String promoCode) async {
    try {
      return await promoCodesCollection.doc(promoCode).get();
    } catch (e) {
      print("Error getting promo code: $e");
      throw e; // Você pode optar por lidar com o erro aqui ou propagá-lo para cima
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
      throw e; // Você pode optar por lidar com o erro aqui ou propagá-lo para cima
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
      return const Stream.empty();
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
        'restaurantId': uid,
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

  // ingredients list from snapshot
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
      throw e; // Você pode optar por lidar com o erro ou propagá-lo para cima
    }
  }

  Future<void> deletePromoCode(String promoCodeId) async {
    try {
      await promoCodesCollection.doc(promoCodeId).delete();
    } catch (e) {
      print("Error deleting promo code: $e");
      throw e; // Você pode optar por lidar com o erro ou propagá-lo para cima
    }
  }

  Future addOrUpdateRestaurantReservationsData(
      String userID,
      String restaurantID,
      List<String> order,
      double cost,
      DateTime date) async {
    try {
      await reservationsCollection.doc('$userID$restaurantID$date').set({
        'userID': userID,
        'restaurantID': restaurantID,
        'order': order,
        'cost': cost,
        'start': date,
        'end': date.add(const Duration(hours: 2)),
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  List<Reservation> _ReservationsListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Reservation(
          userID: doc.get('userID') ?? '',
          restaurantID: doc.get('restaurantID') ?? '',
          order: doc.get('order').map<String>((e) => e).toList(),
          cost: doc.get('cost').toDouble() ?? 0,
          start: doc.get('date').toDate() ?? DateTime.now(),
          end: doc.get('end').toDate() ?? DateTime.now(),
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Stream<dynamic>? reservations(
      {required DateTime start, required DateTime end}) {
    try {
      return reservationsCollection
          .snapshots()
          .map(_ReservationsListFromSnapshot);
    } catch (e) {
      debugPrint(e.toString());
      return const Stream.empty();
    }
  }
  //-----------------RestaurantTypes-----------------

  Future<void> addRestaurantType(String typeName) async {
    try {
      await restaurantTypesCollection.doc(typeName).set({
        'name': typeName,
      });
    } catch (e) {
      print("Error adding restaurant type: $e");
      throw e; // Você pode optar por lidar com o erro aqui ou propagá-lo para cima
    }
  }

  Future<List<DocumentSnapshot>> getRestaurantTypes() async {
    try {
      QuerySnapshot querySnapshot = await restaurantTypesCollection.get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error getting restaurant types: $e");
      throw e;
    }
  }

  Future<void> deleteRestaurantType(String typeId) async {
    try {
      await restaurantTypesCollection.doc(typeId).delete();
    } catch (e) {
      print("Error deleting restaurant type: $e");
      throw e;
    }
  }
}
