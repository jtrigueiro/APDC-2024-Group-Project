import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<List<Map<String, dynamic>>> getUserReviews(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cachedReviews = prefs.getString('cachedReviews_$userId');

  if (cachedReviews != null) {
    List<dynamic> reviewsList = json.decode(cachedReviews);
    return reviewsList.map((review) => review as Map<String, dynamic>).toList();
  } else {
    return fetchAndCacheUserReviews(userId);
  }
}

Future<List<Map<String, dynamic>>> fetchAndCacheUserReviews(
    String userId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('userId', isEqualTo: userId)
        .get();

    List<Map<String, dynamic>> reviews = [];
    for (var doc in querySnapshot.docs) {
      reviews.add(doc.data() as Map<String, dynamic>);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cachedReviews_$userId', json.encode(reviews));

    return reviews;
  } catch (e) {
    print("Error fetching user reviews: $e");
    return [];
  }
}
