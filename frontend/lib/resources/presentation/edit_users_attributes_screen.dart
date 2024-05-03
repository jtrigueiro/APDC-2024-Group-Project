import 'package:adc_handson_session/resources/application/change_attributes.dart';
import 'package:flutter/material.dart';
import 'package:adc_handson_session/resources/application/auth.dart';

class EditUsersAttributesScreen extends StatefulWidget {
  const EditUsersAttributesScreen({super.key});

  @override
  State<EditUsersAttributesScreen> createState() =>
      _EditUsersAttributesScreen();
}

class _EditUsersAttributesScreen extends State<EditUsersAttributesScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController jobController;
  late TextEditingController workPlaceController;
  late TextEditingController homeAddressController;
  late TextEditingController postalCodeController;
  late TextEditingController nifController;
  late TextEditingController targetUsernameController;
  late ScrollController scrollController;
  late bool doPasswordsMatch;
  late String privacyValue;
  late bool isTargetUsernameEmpty;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    jobController = TextEditingController();
    workPlaceController = TextEditingController();
    homeAddressController = TextEditingController();
    postalCodeController = TextEditingController();
    nifController = TextEditingController();
    targetUsernameController = TextEditingController();
    scrollController = ScrollController();
    isTargetUsernameEmpty = false;
    privacyValue = 'Private';
    super.initState();
  }

  void registerButtonPressed(
      String targetUsername,
      String name,
      String phoneNumber,
      String email,
      String job,
      String workPlace,
      String homeAddress,
      String postalCode,
      String nif,
      bool privacy) async {
    if (await ChangeAttributes.changeUserAttributes(
        targetUsername,
        name,
        phoneNumber,
        email,
        job,
        workPlace,
        homeAddress,
        postalCode,
        nif,
        privacy)) {
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
          title: const Text('Our First App - Edit Users Attributes Screen'),
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
                    controller: targetUsernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Target User Name*',
                      errorText: isTargetUsernameEmpty
                          ? 'This field is mandatory'
                          : null,
                    ),
                    onChanged: (value) {
                      if (targetUsernameController.text.isEmpty) {
                        setState(() {
                          isTargetUsernameEmpty = true;
                        });
                      } else {
                        setState(() {
                          isTargetUsernameEmpty = false;
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
                      labelText: 'Full Name**',
                    ),
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
                      labelText: 'Phone Number',
                    ),
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
                      labelText: 'Email**',
                    ),
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), //
                  child: const Text(
                    '* This field is mandatory.\n** This field has no effect for regular users trying to change their own attributes.',
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
                      child: const Text('Confirm changes'),
                      onPressed: () {
                        if (targetUsernameController.text.isEmpty) {
                          setState(() {
                            isTargetUsernameEmpty = true;
                          });
                        } else {
                          registerButtonPressed(
                              targetUsernameController.text,
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
