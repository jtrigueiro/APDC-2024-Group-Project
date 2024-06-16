import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/personal%20informations/personal_information.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/helpAndSupport/help_and_support.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/review/reviews.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/settings/settings_page.dart';
import 'profile_service.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();
  Uint8List? _imageBytes;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    _imageBytes = await _profileService.loadImage();
    _userName = await _profileService.loadUserName();
    setState(() {});
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        await _profileService.saveImage(bytes);
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
                          _userName?.toUpperCase() ?? 'User Name',
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReviewsPage(),
                          ),
                        );
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyRestaurantScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.settings,
                      text: 'Settings',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
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
                        await FirebaseAuth.instance.signOut();
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
