import 'package:flutter/material.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/personal_information.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40), // Adiciona espaço no topo
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              // Adicione a lógica para adicionar uma foto
                            },
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
                        // Adicione a lógica para navegar para Reviews
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.card_giftcard,
                      text: 'Promo codes',
                      onTap: () {
                        // Adicione a lógica para navegar para Promo codes
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.emoji_events,
                      text: 'Achievements',
                      onTap: () {
                        // Adicione a lógica para navegar para Achievements
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.restaurant,
                      text: 'My Restaurant',
                      onTap: () {
                        // Adicione a lógica para navegar para My Restaurant
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.settings,
                      text: 'Settings',
                      onTap: () {
                        // Adicione a lógica para navegar para Settings
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.help,
                      text: 'Help and Support',
                      onTap: () {
                        // Adicione a lógica para navegar para Help and Support
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
