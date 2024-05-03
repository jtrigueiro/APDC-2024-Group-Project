import 'package:adc_handson_session/resources/application/register.dart';
import 'package:flutter/material.dart';
import 'package:adc_handson_session/resources/application/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String privacyValue;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController passwordVerificationController;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController jobController;
  late TextEditingController workPlaceController;
  late TextEditingController homeAddressController;
  late TextEditingController postalCodeController;
  late TextEditingController nifController;
  late ScrollController scrollController;
  late bool isUserNameEmpty;
  late bool isPasswordEmpty;
  late bool isPasswordVerificationEmpty;
  late bool isFullNameEmpty;
  late bool isPhoneNumberEmpty;
  late bool isEmailEmpty;
  late bool doPasswordsMatch;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    passwordVerificationController = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    jobController = TextEditingController();
    workPlaceController = TextEditingController();
    homeAddressController = TextEditingController();
    postalCodeController = TextEditingController();
    nifController = TextEditingController();
    scrollController = ScrollController();
    doPasswordsMatch = true;
    privacyValue = 'Private';
    super.initState();
    isUserNameEmpty = false;
    isPasswordEmpty = false;
    isPasswordVerificationEmpty = false;
    isFullNameEmpty = false;
    isPhoneNumberEmpty = false;
    isEmailEmpty = false;
  }

  void registerButtonPressed(
      String username,
      String password,
      String name,
      String phoneNumber,
      String email,
      String job,
      String workPlace,
      String homeAddress,
      String postalCode,
      String nif,
      bool privacy) async {
    if (await Register.registerUser(username, password, name, phoneNumber,
        email, job, workPlace, homeAddress, postalCode, nif, privacy)) {
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
      // Wrong credentials
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
          title: const Text('Our First App - Register Screen'),
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
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'User Name*',
                      errorText:
                          isUserNameEmpty ? 'This field is mandatory' : null,
                    ),
                    onChanged: (value) {
                      if (usernameController.text.isEmpty) {
                        setState(() {
                          isUserNameEmpty = true;
                        });
                      } else {
                        setState(() {
                          isUserNameEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Password*',
                      errorText:
                          isPasswordEmpty ? 'This field is mandatory' : null,
                    ),
                    onChanged: (value) {
                      if (value != passwordVerificationController.text) {
                        setState(() {
                          doPasswordsMatch = false;
                        });
                      } else {
                        setState(() {
                          doPasswordsMatch = true;
                        });
                      }
                      if (passwordController.text.isEmpty) {
                        setState(() {
                          isPasswordEmpty = true;
                        });
                      } else {
                        setState(() {
                          isPasswordEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordVerificationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Password Verification*',
                      errorText: isPasswordVerificationEmpty
                          ? 'This field is mandatory'
                          : (doPasswordsMatch
                              ? null
                              : 'Passwords do not match'),
                    ),
                    onChanged: (value) {
                      if (value != passwordController.text) {
                        setState(() {
                          doPasswordsMatch = false;
                        });
                      } else {
                        setState(() {
                          doPasswordsMatch = true;
                        });
                      }
                      if (passwordVerificationController.text.isEmpty) {
                        setState(() {
                          isPasswordVerificationEmpty = true;
                        });
                      } else {
                        setState(() {
                          isPasswordVerificationEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Full Name*',
                      errorText:
                          isFullNameEmpty ? 'This field is mandatory' : null,
                    ),
                    onChanged: (value) {
                      if (nameController.text.isEmpty) {
                        setState(() {
                          isFullNameEmpty = true;
                        });
                      } else {
                        setState(() {
                          isFullNameEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Phone Number*',
                      errorText:
                          isPhoneNumberEmpty ? 'This field is mandatory' : null,
                    ),
                    onChanged: (value) {
                      if (phoneNumberController.text.isEmpty) {
                        setState(() {
                          isPhoneNumberEmpty = true;
                        });
                      } else {
                        setState(() {
                          isPhoneNumberEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Email*',
                      errorText:
                          isEmailEmpty ? 'This field is mandatory' : null,
                    ),
                    onChanged: (value) {
                      if (emailController.text.isEmpty) {
                        setState(() {
                          isEmailEmpty = true;
                        });
                      } else {
                        setState(() {
                          isEmailEmpty = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: jobController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Job',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: workPlaceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Work Place',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: homeAddressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Home Address',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: postalCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Postal Code',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: nifController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'NIF',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      const Text(
                        'Account privacy: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: privacyValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            privacyValue = newValue!;
                          });
                        },
                        items: <String>['Private', 'Public']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
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
                      child: const Text('Register Account'),
                      onPressed: () {
                        if (usernameController.text.isEmpty) {
                          setState(() {
                            isUserNameEmpty = true;
                          });
                        } else if (passwordController.text.isEmpty) {
                          setState(() {
                            isPasswordEmpty = true;
                          });
                        } else if (passwordVerificationController
                            .text.isEmpty) {
                          setState(() {
                            isPasswordVerificationEmpty = true;
                          });
                        } else if (!doPasswordsMatch) {
                        } else if (nameController.text.isEmpty) {
                          setState(() {
                            isFullNameEmpty = true;
                          });
                        } else if (phoneNumberController.text.isEmpty) {
                          setState(() {
                            isPhoneNumberEmpty = true;
                          });
                        } else if (emailController.text.isEmpty) {
                          setState(() {
                            isEmailEmpty = true;
                          });
                        } else {
                          registerButtonPressed(
                              usernameController.text,
                              passwordController.text,
                              nameController.text,
                              phoneNumberController.text,
                              emailController.text,
                              jobController.text,
                              workPlaceController.text,
                              homeAddressController.text,
                              postalCodeController.text,
                              nifController.text,
                              privacyValue == 'Private' ? true : false);
                        }
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
