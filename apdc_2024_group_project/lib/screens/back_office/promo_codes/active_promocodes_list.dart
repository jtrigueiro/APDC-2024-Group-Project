import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_group_project/utils/constants.dart' as constants;

class ActivePromoCodesPage extends StatefulWidget {
  @override
  _ActivePromoCodesPageState createState() => _ActivePromoCodesPageState();
}

class _ActivePromoCodesPageState extends State<ActivePromoCodesPage> {
  final DatabaseService _dbService = DatabaseService();
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

    try {
      List<DocumentSnapshot> promoCodes = await _dbService.loadPromoCodes(
        lastDocument: _lastDocument,
        pageSize: _pageSize,
      );

      setState(() {
        _promoCodes.addAll(promoCodes);
        _lastDocument = promoCodes.isNotEmpty ? promoCodes.last : null;
        _isLoading = false;
        _hasMore = promoCodes.length == _pageSize;
      });

      print('Loaded ${promoCodes.length} promo codes');
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
      await _dbService.deletePromoCode(promoCodeId);
      setState(() {
        _promoCodes.removeWhere((promoCode) => promoCode.id == promoCodeId);
      });
      constants.showSnackBar(context, 'Promo code deleted successfully!');
    } catch (e) {
      constants.showSnackBar(context, 'Error deleting promo code. Please try again later.');
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
                          promoCode['reward'].toString(),
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
