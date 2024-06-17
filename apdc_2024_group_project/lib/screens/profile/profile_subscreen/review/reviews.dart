import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
  }

  Future<void> _refreshReviews() async {
    await fetchAndCacheUserReviews(_user.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100], // Cor alterada para laranja
        title: Text(
          'Reviews',
          style: GoogleFonts.getFont(
            'Nunito',
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: const Color(0xFF000000),
          ), // Cor do texto alterada para preto
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Cor do ícone alterada para preto
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh,
                color: Colors.black), // Cor do ícone alterada para preto
            onPressed: _refreshReviews,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for Restaurants',
                prefixIcon: Icon(Icons.search),
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
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getUserReviews(_user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No reviews yet', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
                } else {
                  var filteredReviews = snapshot.data!.where((review) {
                    return review['restaurantName']
                        .toString()
                        .toLowerCase()
                        .contains(_searchText);
                  }).toList();

                  if (filteredReviews.isEmpty) {
                    return Center(child: Text('No matching reviews found'));
                  }

                  return ListView.builder(
                    itemCount: filteredReviews.length,
                    itemBuilder: (context, index) {
                      var review = filteredReviews[index];
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
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
