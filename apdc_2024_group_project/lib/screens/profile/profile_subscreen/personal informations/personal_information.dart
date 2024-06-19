import 'dart:typed_data';
import 'package:adc_group_project/utils/themes/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adc_group_project/screens/profile/profile_service.dart';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User _user;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late SharedPreferences _prefs;
  final ProfileService _profileService = ProfileService();
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _initPreferences();
    _initializeProfile();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadUserData();
  }

  Future<void> _initializeProfile() async {
    _imageBytes = await _profileService.loadImage();
    setState(() {});
  }

  Future<void> _loadUserData() async {
    try {
      String name = _prefs.getString('userName') ?? '';
      String email = _prefs.getString('userEmail') ?? '';

      if (name.isEmpty || email.isEmpty) {
        DocumentSnapshot userData =
            await _firestore.collection('users').doc(_user.uid).get();
        if (userData.exists) {
          setState(() {
            name = userData['name'] ?? '';
            email = userData['email'] ?? _user.email!;
            _nameController.text = name;
            _emailController.text = email;
          });
          _prefs.setString('userName', name);
          _prefs.setString('userEmail', email);
        } else {
          print("Documento do usuário não existe no Firestore.");
        }
      } else {
        setState(() {
          _nameController.text = name;
          _emailController.text = email;
        });
      }
    } catch (e) {
      print("Erro ao carregar os dados do usuário: $e");
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firestore.collection('users').doc(_user.uid).update({
          'name': _nameController.text,
          'email': _emailController.text,
        });

        setState(() {
          _prefs.setString('userName', _nameController.text);
          _prefs.setString('userEmail', _emailController.text);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Informações atualizadas com sucesso')),
        );
      } catch (e) {
        print("Erro ao atualizar os dados do usuário: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar informações: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 117, 85, 18)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                  child: _imageBytes == null
                      ? Icon(Icons.person, color: Colors.white, size: 40)
                      : null,
                ),
                SizedBox(height: 10),
                Text(
                  _nameController.text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  _emailController.text,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateUserData,
                  style: ElButtonThemeApp.LightElButtonTheme.style,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
