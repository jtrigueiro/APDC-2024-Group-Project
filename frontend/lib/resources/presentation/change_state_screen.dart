import 'package:adc_handson_session/resources/application/change_state.dart';
import 'package:flutter/material.dart';
import 'package:adc_handson_session/resources/application/auth.dart';

class ChanteStateScreen extends StatefulWidget {
  const ChanteStateScreen({super.key});

  @override
  State<ChanteStateScreen> createState() => _ChanteStateScreen();
}

class _ChanteStateScreen extends State<ChanteStateScreen> {
  late TextEditingController targetUsernameController;
  late ScrollController scrollController;
  late bool isUserNameEmpty;

  @override
  void initState() {
    targetUsernameController = TextEditingController();
    scrollController = ScrollController();
    isUserNameEmpty = false;
    super.initState();
  }

  void registerButtonPressed(String targetUsername) async {
    if (await ChangeState.changeUserState(targetUsername)) {
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
          title: const Text('Our First App - Change State Screen'),
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
                        child: const Text('Confirm account state change'),
                        onPressed: () {
                          if (targetUsernameController.text.isEmpty) {
                            setState(() {
                              isUserNameEmpty = true;
                            });
                          } else {
                            registerButtonPressed(
                                targetUsernameController.text);
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
