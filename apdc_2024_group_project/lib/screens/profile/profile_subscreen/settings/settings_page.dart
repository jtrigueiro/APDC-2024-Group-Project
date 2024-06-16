import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
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
      DocumentSnapshot userSettings = await _firestore
          .collection('NotificationSettings')
          .doc(_user.uid)
          .get();
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
      await _firestore.collection('NotificationSettings').doc(_user.uid).set({
        'specialOffers': _specialOffers,
        'reservationInfo': _reservationInfo,
      });
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
          title: Text('Delete Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete your account?'),
                Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
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
      // Remover dados do Firestore
      await _firestore
          .collection('NotificationSettings')
          .doc(_user.uid)
          .delete();
      await _firestore.collection('Users').doc(_user.uid).delete();
      await _firestore.collection('supportMessages').doc(_user.uid).delete();
      // Outros dados relacionados ao usuário no Firestore também devem ser removidos aqui

      // Deletar usuário do Firebase Authentication
      await _user.delete();

      // Redirecionar para a página de login
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

      // Mostrar SnackBar com a mensagem
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account deleted successfully.'),
          duration: Duration(seconds: 3), // Duração do SnackBar
        ),
      );
    } catch (e) {
      print("Error deleting account: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account. Please try again.'),
          duration: Duration(seconds: 3), // Duração do SnackBar
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200], // Cor verde claro
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
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
          _buildSectionTitle('Geo Location'),
          _buildListTile(
            'Set Location Preferences',
            onTap: () {
              // Ação para definir preferências de localização
            },
          ),
          _buildSectionTitle('Privacy'),
          _buildListTile(
            'Terms of Use',
            onTap: () {
              // Ação para exibir os Termos de Uso
            },
          ),
          _buildListTile(
            'Privacy Policy',
            onTap: () {
              // Ação para exibir a Política de Privacidade
            },
          ),
          _buildListTile(
            'Manage Privacy',
            onTap: () {
              // Ação para gerenciar a privacidade
            },
          ),
          _buildListTile(
            'Delete My Account',
            onTap: _confirmDeleteAccount,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchListTile(
      String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.amber[800], // Cor do switch ativo
    );
  }

  Widget _buildListTile(String title,
      {required Function() onTap, Color? color}) {
    return ListTile(
      title: Text(title, style: TextStyle(color: color)),
      trailing: Icon(Icons.chevron_right, color: color),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      tileColor: Colors.grey[200],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
