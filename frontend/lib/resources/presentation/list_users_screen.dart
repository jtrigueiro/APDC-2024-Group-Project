import 'package:adc_handson_session/resources/application/list_users.dart';
import 'package:flutter/material.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({super.key});

  @override
  State<ListUsersScreen> createState() => _ListUsersScreen();
}

class _ListUsersScreen extends State<ListUsersScreen> {
  late List usersList;

  @override
  void initState() {
    usersList = [];
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    List list = await ListUsers.listUsers();
    setState(() {
      usersList = list;
    });
    if (usersList.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("No users found!"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our First App - List Users Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return Card(
                  key: ValueKey(usersList[index]["username"]),
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Text(usersList[index]["username"]),
                    title: Text(usersList[index]["name"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Phone Number: ${usersList[index]["phoneNumber"]}"),
                        Text("Email: ${usersList[index]["email"]}"),
                        Text("Job: ${usersList[index]["job"]}"),
                        Text("Work place: ${usersList[index]["workPlace"]}"),
                        Text("Address: ${usersList[index]["address"]}"),
                        Text("Postal code: ${usersList[index]["postalCode"]}"),
                        Text("NIF: ${usersList[index]["NIF"]}"),
                        Text(
                            "Account system role: ${usersList[index]["role"]}"),
                        Text(
                            "Account activation state: ${usersList[index]["state"]}"),
                        Text(
                            "Account Privacy: ${usersList[index]["isPrivate"].toString()}"),
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
