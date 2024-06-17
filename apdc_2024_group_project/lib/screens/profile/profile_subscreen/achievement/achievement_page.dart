import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } else {
      // Handle the case where the user is not logged in
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Achievements'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Achievements')),
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_user.uid)
            .collection('achievements')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var achievementDocs = snapshot.data!.docs;

          if (achievementDocs.isEmpty) {
            return Center(child: Text('No achievements yet.'));
          }

          return ListView.builder(
            itemCount: achievementDocs.length,
            itemBuilder: (context, index) {
              var achievement = achievementDocs[index];
              var achievedAt = achievement['achievedAt'].toDate();
              var formattedDate = DateFormat('dd/MM/yyyy').format(achievedAt);

              return ListTile(
                title: Text(achievement['name']),
                subtitle: Text(achievement['description']),
                trailing: Text(
                  'Achieved on: $formattedDate',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
