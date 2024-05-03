import 'package:adc_handson_session/resources/application/change_password.dart';
import 'package:flutter/material.dart';
import 'package:adc_handson_session/resources/application/auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  late String privacyValue;
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController newPasswordVerificationController;
  late ScrollController scrollController;
  late bool isCurrentPasswordEmpty;
  late bool isNewPasswordEmpty;
  late bool isNewPasswordVerificationEmpty;
  late bool doPasswordsMatch;

  @override
  void initState() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    newPasswordVerificationController = TextEditingController();
    scrollController = ScrollController();
    doPasswordsMatch = true;
    super.initState();
    isCurrentPasswordEmpty = false;
    isNewPasswordEmpty = false;
    isNewPasswordVerificationEmpty = false;
  }

  void registerButtonPressed(
    String currentPassowrd,
    String newPassword,
  ) async {
    if (await ChangePassword.changePassword(currentPassowrd, newPassword)) {
      String message = await Authentication.getResponse();
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        },
      );
    } else {
      String message = await Authentication.getResponse();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Our First App - Change Password Screen'),
        ),
        body: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    obscureText: true,
                    controller: currentPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Current Password*',
                      errorText: isCurrentPasswordEmpty
                          ? 'This field is mandatory'
                          : null,
                    ),
                    onChanged: (value) {
                      if (currentPasswordController.text.isEmpty) {
                        setState(() {
                          isCurrentPasswordEmpty = true;
                        });
                      } else {
                        setState(() {
                          isCurrentPasswordEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    obscureText: true,
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'New Password*',
                      errorText:
                          isNewPasswordEmpty ? 'This field is mandatory' : null,
                    ),
                    onChanged: (value) {
                      if (value != newPasswordVerificationController.text) {
                        setState(() {
                          doPasswordsMatch = false;
                        });
                      } else {
                        setState(() {
                          doPasswordsMatch = true;
                        });
                      }
                      if (newPasswordController.text.isEmpty) {
                        setState(() {
                          isNewPasswordEmpty = true;
                        });
                      } else {
                        setState(() {
                          isNewPasswordEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    obscureText: true,
                    controller: newPasswordVerificationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'New Password Verification*',
                      errorText: isNewPasswordVerificationEmpty
                          ? 'This field is mandatory'
                          : (doPasswordsMatch
                              ? null
                              : 'Passwords do not match'),
                    ),
                    onChanged: (value) {
                      if (value != newPasswordController.text) {
                        setState(() {
                          doPasswordsMatch = false;
                        });
                      } else {
                        setState(() {
                          doPasswordsMatch = true;
                        });
                      }
                      if (newPasswordVerificationController.text.isEmpty) {
                        setState(() {
                          isNewPasswordVerificationEmpty = true;
                        });
                      } else {
                        setState(() {
                          isNewPasswordVerificationEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const Text(
                    '* This field is mandatory',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Confirm password change'),
                      onPressed: () {
                        if (currentPasswordController.text.isEmpty) {
                          setState(() {
                            isCurrentPasswordEmpty = true;
                          });
                        } else if (newPasswordController.text.isEmpty) {
                          setState(() {
                            isNewPasswordEmpty = true;
                          });
                        } else if (newPasswordVerificationController
                            .text.isEmpty) {
                          setState(() {
                            isNewPasswordVerificationEmpty = true;
                          });
                        } else if (!doPasswordsMatch) {
                        } else {
                          registerButtonPressed(currentPasswordController.text,
                              newPasswordController.text);
                        }
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
