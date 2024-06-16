import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User _user;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController(text: _user.email);
    _phoneController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Verificar se existem dados salvos localmente
      if (prefs.containsKey('userData')) {
        Map<String, dynamic> userData =
            Map<String, dynamic>.from(prefs.getString('userData')! as Map);
        setState(() {
          _firstNameController.text = userData['firstName'] ?? '';
          _lastNameController.text = userData['lastName'] ?? '';
          _phoneController.text = userData['phone'] ?? '';
        });
      } else {
        // Caso não haja dados salvos localmente, buscar no Firestore
        DocumentSnapshot userData =
            await _firestore.collection('users').doc(_user.uid).get();
        if (userData.exists) {
          setState(() {
            _firstNameController.text = userData['firstName'] ?? '';
            _lastNameController.text = userData['lastName'] ?? '';
            _phoneController.text = userData['phone'] ?? '';
          });
          // Salvar os dados localmente para futuros acessos rápidos
          prefs.setString('userData', userData.data()!.toString());
        } else {
          print("Documento do usuário não existe.");
        }
      }
    } catch (e) {
      print("Erro ao carregar os dados do usuário: $e");
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Atualizar os dados no Firestore
        await _firestore.collection('users').doc(_user.uid).update({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'phone': _phoneController.text,
        });

        // Atualizar os dados localmente após a atualização no Firestore
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> userData = {
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'phone': _phoneController.text,
        };
        prefs.setString('userData', userData.toString());

        // Atualizar o email do usuário no FirebaseAuth
        await _user.updateEmail(_emailController.text);

        // Exibir uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Informações atualizadas com sucesso')),
        );
      } catch (e) {
        print("Erro ao atualizar os dados do usuário: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar informações: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800], // Change to orange
        title: Text('Personal Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'User Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _user.email ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First name*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last name*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone number*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Adicione a lógica para mudar a senha
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateUserData,
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[800], // Change to orange
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
