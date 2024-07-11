import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/settings/settingsSubPages/privacy_police.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/settings/settingsSubPages/terms_of_use_page.dart';
import 'package:adc_group_project/utils/constants.dart' as constants;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dbService = DatabaseService();

  late User _user;
  bool _specialOffers = false;
  bool _reservationInfo = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _loadUserSettings();
  }

  Future<void> _loadUserSettings() async {
    try {
      DocumentSnapshot userSettings =
          await _dbService.getUserSettings(_user.uid);
      if (userSettings.exists) {
        setState(() {
          _specialOffers = userSettings['specialOffers'] ?? false;
          _reservationInfo = userSettings['reservationInfo'] ?? false;
        });
      }
    } catch (e) {
      print("Error loading user settings: $e");
    }
  }

  Future<void> _updateUserSettings() async {
    try {
      await _dbService.updateUserSettings(
          _user.uid, _specialOffers, _reservationInfo);
    } catch (e) {
      print("Error updating user settings: $e");
    }
  }

  Future<void> _confirmDeleteAccount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // O usuário deve tocar no botão de confirmação
      builder: (BuildContext context) {
        return AlertDialog(

          title: const Text('Delete Account', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete your account?', textAlign: TextAlign.center ,style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text('This action cannot be undone.', textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.error)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    try {
      await _dbService.deleteUserNotificationSettings(_user.uid);
      await _dbService.deleteUserPromos(_user.uid);
      await _dbService.deleteUserFavoriteRestaurants(_user.uid);
      await _dbService.deleteUser(_user.uid);

      await _user.delete();

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

      constants.showSnackBar(context, 'Account deleted successfully.');
    } catch (e) {
      constants.showSnackBar(context, 'Failed to delete account. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Push Notifications'),
          _buildSwitchListTile(
            'Special Offers and News',
            _specialOffers,
            (value) {
              setState(() {
                _specialOffers = value;
                _updateUserSettings();
              });
            },
          ),
          _buildSwitchListTile(
            'Reservation Information',
            _reservationInfo,
            (value) {
              setState(() {
                _reservationInfo = value;
                _updateUserSettings();
              });
            },
          ),
          _buildSectionTitle('Privacy'),
          _buildListTile(
            'Terms of Use',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TermsOfUsePage(),
                ),
              );
            },
            color: Theme.of(context).colorScheme.onBackground,
          ),
          _buildListTile(
            'Privacy Policy',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicyPage(),
                ),
              );
            },
            color: Theme.of(context).colorScheme.onBackground,
          ),
          _buildListTile('Delete My Account',
              onTap: _confirmDeleteAccount, color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 17)
      ),
    );
  }

  Widget _buildSwitchListTile(
      String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onBackground)),
      value: value,
      onChanged: onChanged,
      activeColor:
          Theme.of(context).colorScheme.onBackground,
    );
  }

  Widget _buildListTile(String title,
      {required Function() onTap, Color? color}) {
    return ListTile(
      title: Text(title,
          style:
              Theme.of(context).textTheme.titleSmall!.copyWith(color: color)),
      trailing: Icon(Icons.chevron_right, color: color),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      tileColor: const Color.fromARGB(82, 230, 230, 230),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
