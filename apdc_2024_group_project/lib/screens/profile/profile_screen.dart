import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/personal_information.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/help_and_support.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? imageBase64 = prefs.getString('profile_image');
      if (imageBase64 != null) {
        setState(() {
          _imageBytes = base64Decode(imageBase64);
        });
      }
    } catch (e) {
      print("Erro ao carregar a imagem: $e");
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      print("Imagem selecionada: ${pickedFile?.path}");

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        String imageBase64 = base64Encode(bytes);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image', imageBase64);
        setState(() {
          _imageBytes = bytes;
        });
      }
    } catch (e) {
      print("Erro ao selecionar a imagem: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40), // Espaço no topo
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                            backgroundImage: _imageBytes != null
                                ? MemoryImage(_imageBytes!)
                                : null,
                            child: _imageBytes == null
                                ? Icon(Icons.camera_alt, color: Colors.white)
                                : null,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    ProfileMenuItem(
                      icon: Icons.person,
                      text: 'Personal Information',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PersonalInformationScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.reviews,
                      text: 'Reviews',
                      onTap: () {
                        // Navegar para Reviews
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.card_giftcard,
                      text: 'Promo codes',
                      onTap: () {
                        // Navegar para Promo codes
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.emoji_events,
                      text: 'Achievements',
                      onTap: () {
                        // Navegar para Achievements
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.restaurant,
                      text: 'My Restaurant',
                      onTap: () {
                        // Navegar para My Restaurant
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.settings,
                      text: 'Settings',
                      onTap: () {
                        // Navegar para Settings
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.help,
                      text: 'Help and Support',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HelpAndSupportScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.logout,
                      text: 'Log Out',
                      textColor: Colors.red,
                      onTap: () async {
                        await _auth.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  final Color? textColor;

  ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
