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
        const SnackBar(content: Text('Mensagem excluída com sucesso!')),
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Support Messages',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadMessages,
          ),
        ],
      ),
      body: _messages.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                var message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            message['email'],
                            style: Theme.of(context).textTheme.titleSmall),

                          Text(message['message'],style: Theme.of(context).textTheme.titleMedium),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  message['timestamp'] != null
                                      ? (message['timestamp'] as Timestamp)
                                      .toDate()
                                      .toString()
                                      : 'No date',
                                  style: Theme.of(context).textTheme.labelSmall
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteMessage(message.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
