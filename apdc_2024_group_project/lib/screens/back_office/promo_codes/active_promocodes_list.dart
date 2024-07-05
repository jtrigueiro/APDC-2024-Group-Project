import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivePromoCodesPage extends StatefulWidget {
  @override
  _ActivePromoCodesPageState createState() => _ActivePromoCodesPageState();
}

class _ActivePromoCodesPageState extends State<ActivePromoCodesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> _promoCodes = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadPromoCodes();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _loadPromoCodes() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    Query query = _firestore.collection('promo_codes').limit(_pageSize);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    try {
      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _promoCodes.addAll(querySnapshot.docs);
          _lastDocument = querySnapshot.docs.last;
          _isLoading = false;
          _hasMore = querySnapshot.docs.length == _pageSize;
        });
        print('Loaded ${querySnapshot.docs.length} promo codes');
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
      print("Error loading promo codes: $e");
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadPromoCodes();
    }
  }

  Future<void> _deletePromoCode(String promoCodeId) async {
    try {
      await _firestore.collection('promo_codes').doc(promoCodeId).delete();
      setState(() {
        _promoCodes.removeWhere((promoCode) => promoCode.id == promoCodeId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Promoção excluída com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir promoção: $e')),
      );
    }
  }

  Future<void> _reloadPromoCodes() async {
    setState(() {
      _promoCodes = [];
      _lastDocument = null;
      _hasMore = true;
    });
    _loadPromoCodes();
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
        title: const Text('Active Promo Codes'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reloadPromoCodes,
          ),
        ],
      ),
      body: _promoCodes.isEmpty && _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _promoCodes.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _promoCodes.length) {
                  return Center(child: CircularProgressIndicator());
                }
                var promoCode = _promoCodes[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          promoCode.id,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          promoCode['reward'],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deletePromoCode(promoCode.id),
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
