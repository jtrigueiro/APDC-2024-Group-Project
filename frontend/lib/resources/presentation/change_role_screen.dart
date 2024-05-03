import 'package:adc_handson_session/resources/application/change_role.dart';
import 'package:flutter/material.dart';
import 'package:adc_handson_session/resources/application/auth.dart';

class ChanteRoleScreen extends StatefulWidget {
  const ChanteRoleScreen({super.key});

  @override
  State<ChanteRoleScreen> createState() => _ChanteRoleScreen();
}

class _ChanteRoleScreen extends State<ChanteRoleScreen> {
  late String newRoleValue;
  late TextEditingController targetUsernameController;
  late ScrollController scrollController;
  late bool isUserNameEmpty;

  @override
  void initState() {
    targetUsernameController = TextEditingController();
    scrollController = ScrollController();
    isUserNameEmpty = false;
    newRoleValue = 'USER';
    super.initState();
  }

  void registerButtonPressed(
    String targetUsername,
    String newRole,
  ) async {
    if (await ChangeRole.changeUserRole(targetUsername, newRole)) {
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
          title: const Text('Our First App - Change Role Screen'),
        ),
        body: Center(
          child: Scrollbar(
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
                        errorText:
                            isUserNameEmpty ? 'This field is mandatory' : null,
                      ),
                      onChanged: (value) {
                        if (targetUsernameController.text.isEmpty) {
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
                    child: Row(
                      children: [
                        const Text(
                          'Account Role: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: newRoleValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              newRoleValue = newValue!;
                            });
                          },
                          items: <String>['SU', 'GA', 'GBO', 'USER']
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
                        child: const Text('Confirm account role change'),
                        onPressed: () {
                          if (targetUsernameController.text.isEmpty) {
                            setState(() {
                              isUserNameEmpty = true;
                            });
                          } else {
                            registerButtonPressed(
                                targetUsernameController.text, newRoleValue);
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
