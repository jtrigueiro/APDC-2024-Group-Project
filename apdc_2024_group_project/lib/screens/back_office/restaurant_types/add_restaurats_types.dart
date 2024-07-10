import 'package:flutter/material.dart';
import 'package:adc_group_project/services/firestore_database.dart';
class AddRestaurantTypePage extends StatefulWidget {
  @override
  _AddRestaurantTypePageState createState() => _AddRestaurantTypePageState();
}

class _AddRestaurantTypePageState extends State<AddRestaurantTypePage> {
  final TextEditingController _typeController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();
  bool _isLoading = false;

  Future<void> _addRestaurantType() async {
    String typeName = _typeController.text.trim();

    if (typeName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a restaurant type'),
        duration: Duration(seconds: 1),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _dbService.addRestaurantType(typeName);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restaurant type added successfully!'),
        duration: Duration(seconds: 1),
      ));
      _typeController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add restaurant type'),
        duration: Duration(seconds: 1),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Restaurant Type'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: 'Restaurant Type',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a restaurant type';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _addRestaurantType,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Add Type'),
            ),
          ],
        ),
      ),
    );
  }
}