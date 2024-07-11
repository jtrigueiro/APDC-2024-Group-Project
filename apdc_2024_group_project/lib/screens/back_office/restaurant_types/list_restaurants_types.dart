import 'package:flutter/material.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_group_project/utils/constants.dart' as constants;

class ListRestaurantTypesPage extends StatefulWidget {
  @override
  _ListRestaurantTypesPageState createState() =>
      _ListRestaurantTypesPageState();
}

class _ListRestaurantTypesPageState extends State<ListRestaurantTypesPage> {
  final DatabaseService _dbService = DatabaseService();
  List<DocumentSnapshot> _restaurantTypes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRestaurantTypes();
  }

  Future<void> _loadRestaurantTypes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<DocumentSnapshot> restaurantTypes = await _dbService.getRestaurantTypes();
      setState(() {
        _restaurantTypes = restaurantTypes;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading restaurant types: $e");
      setState(() {
        _isLoading = false;
      });
      constants.showSnackBar(context, 'Error loading restaurant types');
    }
  }

  Future<void> _deleteRestaurantType(String typeId) async {
    try {
      await _dbService.deleteRestaurantType(typeId);
      setState(() {
        _restaurantTypes.removeWhere((type) => type.id == typeId);
      });
      constants.showSnackBar(context, 'Restaurant type deleted successfully!');
    } catch (e) {
      constants.showSnackBar(context, 'Failed to delete restaurant type: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Types'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _restaurantTypes.length,
              itemBuilder: (context, index) {
                var restaurantType = _restaurantTypes[index];
                return ListTile(
                  title: Text(restaurantType['name']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteRestaurantType(restaurantType.id),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadRestaurantTypes,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}