import 'dart:typed_data';
import 'package:adc_group_project/screens/profile/profile_subscreen/achievement/achievement_page.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_screen_router.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/promo_codes/promo_codes.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/personal%20informations/personal_information.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/help_and_support/help_and_support.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/review/reviews.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/settings/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  double iconSize(BuildContext context) {
    if (kIsWeb) {
      return 25;
    } else {
      return MediaQuery.of(context).size.width * 0.055;
    }
  }

  Future<void> _initializeProfile() async {
    _imageBytes = await _profileService.loadImage();
    _userName = await DatabaseService().loadUserName();
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey,
                      backgroundImage: _imageBytes != null
                          ? MemoryImage(_imageBytes!)
                          : null,
                      child: InkWell(
                        onTap: () {
                          if (_imageBytes != null) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Dialog(
                                      elevation: 3,
                                      backgroundColor: Colors.blueGrey,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: _imageBytes != null
                                            ? Image.memory(_imageBytes!)
                                            : null,
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        child: _imageBytes == null
                            ? const Icon(Icons.camera_alt, color: Colors.white)
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 90, left: 100),
                      child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: _pickImage,
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _userName ?? 'User Name',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      profileItem(
                        context,
                        Icons.reviews_outlined,
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
                        Icons.emoji_events_outlined,
                        'Achievements',
                        ontapAchivements(context),
                      ),
                      profileItem(
                        context,
                        Icons.food_bank_outlined,
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
                        Icons.help_outline,
                        'Help and Support',
                        ontapHelpSupport(context),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.error,
                          size: iconSize(context),
                        ),
                        title: Text(
                          'Log Out',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 17),
                        ),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          await SharedPreferences.getInstance()
                              .then((prefs) => prefs.clear()); // Limpa o cache
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        builder: (context) => const HelpAndSupportScreen(),
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
      leading: Icon(icon, size: iconSize(context)),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 17),
      ),
      onTap: onTap,
    );
  }

  double iconSize(BuildContext context) {
    if (kIsWeb) {
      return 25;
    } else {
      return MediaQuery.of(context).size.width * 0.055;
    }
  }


}
