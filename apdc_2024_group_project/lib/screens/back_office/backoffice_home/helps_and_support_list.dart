import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupportMessagesListScreen extends StatefulWidget {
  @override
  _SupportMessagesListScreenState createState() =>
      _SupportMessagesListScreenState();
}

class _SupportMessagesListScreenState extends State<SupportMessagesListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _deleteMessage(String messageId) async {
    try {
      await _firestore.collection('supportMessages').doc(messageId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mensagem excluída com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir mensagem: $e')),
      );
    }
  }

  Future<void> _reloadMessages() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support Messages',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reloadMessages,
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _firestore
            .collection('supportMessages')
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No support messages found.'));
          }

          var messages = snapshot.data!.docs;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['email'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(message['message']),
                      SizedBox(height: 5),
                      Text(
                        message['timestamp'] != null
                            ? (message['timestamp'] as Timestamp)
                                .toDate()
                                .toString()
                            : 'No date',
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteMessage(message.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
