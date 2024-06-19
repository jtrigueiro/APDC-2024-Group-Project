import 'dart:typed_data';
import 'package:adc_group_project/screens/profile/profile_subscreen/achievement/achievement_page.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_screen_router.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/promo_codes/promo_codes.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/personal%20informations/personal_information.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/help_and_support/help_and_support.dart';
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
  final AuthService _auth = AuthService();

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
                    customSpaceBetweenColumns(40),
                    profileItem(
                      context,
                      Icons.person,
                      'Personal Information',
                      ontapPersInformation(context),
                    ),
                    profileItem(
                      context,
                      Icons.reviews,
                      'Reviews',
                      ontapReviews(context),
                    ),
                    profileItem(
                      context,
                      Icons.card_giftcard,
                      'Promo codes',
                      ontapPromo(context),
                    ),
                    profileItem(
                      context,
                      Icons.emoji_events,
                      'Achievements',
                      ontapAchivements(context),
                    ),
                    profileItem(
                      context,
                      Icons.restaurant,
                      'My Restaurant',
                      ontapMyRestaurant(context),
                    ),
                    profileItem(
                      context,
                      Icons.settings,
                      'Settings',
                      ontapSettings(context),
                    ),
                    profileItem(
                      context,
                      Icons.help,
                      'Help and Support',
                      ontapHelpSupport(context),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout,
                          color: Theme.of(context).colorScheme.error),
                      title: Text(
                        'Log Out',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.error),
                      ),
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

ProfileMenuItem profileItem(context, icon, texts, ontap) {
  return ProfileMenuItem(
    icon: icon,
    text: texts,
    textColor: Theme.of(context).colorScheme.secondary,
    onTap: ontap,
  );
}

Function ontapPersInformation(context) {
  return () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PersonalInformationScreen(),
      ),
    );
  };
}

Function ontapReviews(context) {
  return () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReviewsPage(),
      ),
    );
  };
}

Function ontapPromo(context) {
  return () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PromoCodesPage(),
      ),
    );
  };
}

Function ontapAchivements(context) {
  return () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AchievementsScreen(),
      ),
    );
  };
}

Function ontapMyRestaurant(context) {
  return () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyRestaurantScreenRouter(),
      ),
    );
  };
}

Function ontapSettings(context) {
  return () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  };
}

Function ontapHelpSupport(context) {
  return () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HelpAndSupportScreen(),
      ),
    );
  };
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
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: onTap,
    );
  }
}
