import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupportMessagesListScreen extends StatefulWidget {
  @override
  _SupportMessagesListScreenState createState() =>
      _SupportMessagesListScreenState();
}

class _SupportMessagesListScreenState extends State<SupportMessagesListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> _messages = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _loadMessages() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    Query query = _firestore
        .collection('support_messages')
        .orderBy('timestamp', descending: true)
        .limit(_pageSize);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    try {
      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _messages.addAll(querySnapshot.docs);
          _lastDocument = querySnapshot.docs.last;
          _isLoading = false;
          _hasMore = querySnapshot.docs.length == _pageSize;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error loading messages: $e");
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMessages();
    }
  }

  Future<void> _deleteMessage(String messageId) async {
    try {
      await _firestore.collection('support_messages').doc(messageId).delete();
      setState(() {
        _messages.removeWhere((message) => message.id == messageId);
      });
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
    setState(() {
      _messages = [];
      _lastDocument = null;
      _hasMore = true;
    });
    _loadMessages();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      body: _messages.isEmpty && _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return Center(child: CircularProgressIndicator());
                }
                var message = _messages[index];
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
            ),
    );
  }
}
