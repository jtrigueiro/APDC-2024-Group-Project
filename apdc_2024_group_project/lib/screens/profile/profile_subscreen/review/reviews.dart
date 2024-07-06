import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'getUserReviews.dart';

class ReviewsPage extends StatefulWidget {
  ReviewsPage({super.key});

  @override
  _ReviewsPage createState() => _ReviewsPage();
}

class _ReviewsPage extends State<ReviewsPage> {
  final _auth = FirebaseAuth.instance;
  late User _user;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<Map<String, dynamic>> _reviews = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, dynamic>> newReviews =
          await fetchUserReviewsWithPagination(
        _user.uid,
        _pageSize,
        _lastDocument,
      );

      setState(() {
        _reviews.addAll(newReviews);
        _isLoading = false;
        _hasMore = newReviews.length == _pageSize;
        if (newReviews.isNotEmpty) {
          _lastDocument = newReviews.last['documentSnapshot'];
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching reviews: $e");
    }
  }

  Future<void> _refreshReviews() async {
    setState(() {
      _reviews = [];
      _lastDocument = null;
      _hasMore = true;
    });
    await _fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshReviews,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for Restaurants',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!_isLoading &&
                    _hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  _fetchReviews();
                }
                return false;
              },
              child: _isLoading && _reviews.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _reviews.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _reviews.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var review = _reviews[index];
                        if (review['restaurantName']
                            .toString()
                            .toLowerCase()
                            .contains(_searchText)) {
                          return ListTile(
                            title: Text(review['restaurantName']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(review['text']),
                                SizedBox(height: 5),
                                Text('Rating: ${review['rating']}'),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
