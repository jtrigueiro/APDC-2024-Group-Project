import 'package:adc_handson_session/resources/application/list_user.dart';
import 'package:flutter/material.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreen();
}

class _ListUserScreen extends State<ListUserScreen> {
  late List userList;

  @override
  void initState() {
    userList = [];
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    List list = await ListUser.listUser();
    setState(() {
      userList = list;
    });
    if (userList.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Error loading, try again later!"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our First App - Profile Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Card(
                  key: ValueKey(userList[index]["username"]),
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Text(userList[index]["username"]),
                    title: Text(userList[index]["name"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone Number: ${userList[index]["phoneNumber"]}"),
                        Text("Email: ${userList[index]["email"]}"),
                        Text("Job: ${userList[index]["job"]}"),
                        Text("Work place: ${userList[index]["workPlace"]}"),
                        Text("Address: ${userList[index]["address"]}"),
                        Text("Postal code: ${userList[index]["postalCode"]}"),
                        Text("NIF: ${userList[index]["NIF"]}"),
                        Text("Account system role: ${userList[index]["role"]}"),
                        Text(
                            "Account activation state: ${userList[index]["state"]}"),
                        Text(
                            "Account Privacy: ${userList[index]["isPrivate"].toString()}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
