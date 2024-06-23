import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivePromoCodesPage extends StatefulWidget {
  @override
  _ActivePromoCodesPageState createState() => _ActivePromoCodesPageState();
}

class _ActivePromoCodesPageState extends State<ActivePromoCodesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _deletePromoCode(String promoCodeId) async {
    try {
      await _firestore.collection('promo_codes').doc(promoCodeId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Promoção excluída com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir promoção: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Promo Codes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('promo_codes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var promoCodes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: promoCodes.length,
            itemBuilder: (context, index) {
              var promoCode = promoCodes[index];
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
          );
        },
      ),
    );
  }
}
