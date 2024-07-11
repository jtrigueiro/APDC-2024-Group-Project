import 'package:flutter/material.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/constants.dart' as constants;

class AddRestaurantTypePage extends StatefulWidget {
  @override
  _AddRestaurantTypePageState createState() => _AddRestaurantTypePageState();
}

class _AddRestaurantTypePageState extends State<AddRestaurantTypePage> {
  final TextEditingController _typeController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();
  bool _isLoading = false;

  Future<void> _addRestaurantType() async {
    String typeName = _typeController.text.trim().toLowerCase();

    if (typeName.isEmpty) {
      constants.showSnackBar(context, 'Please enter a restaurant type');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      bool typeExists = await _dbService.restaurantTypeExists(typeName);
      if (typeExists) {
        constants.showSnackBar(context, 'Restaurant type already exists');
        _typeController.clear();
        return;
      }
      else {
        await _dbService.addRestaurantType(typeName);
        constants.showSnackBar(context, 'Restaurant type added successfully');
      }

    } catch (e) {
      constants.showSnackBar(context, 'Failed to add restaurant type. Please try again.');
    } finally {
      _typeController.clear();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Restaurant Type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _typeController,
              decoration: const InputDecoration(
                labelText: 'Restaurant Type',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a restaurant type';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _addRestaurantType,
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Add Type'),
            ),
          ],
        ),
      ),
    );
  }
}