import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  bool _showContactForm = false;

  Future<void> _sendEmailAndAddToFirestore() async {
    final String body = _controller.text.trim();

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Gerar um ID único para cada mensagem
        String messageId =
            FirebaseFirestore.instance.collection('support_messages').doc().id;

        // Adicionar a mensagem ao Firestore com um novo ID único
        await FirebaseFirestore.instance
            .collection('support_messages')
            .doc(messageId)
            .set({
          'userId': userId, // Associar à ID do usuário
          'email': user.email,
          'message': body,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Exibir uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mensagem enviada com sucesso!')),
        );

        // Realizar o pop da navegação após o sucesso
        Navigator.of(context).pop();
      } else {
        // Trate o caso em que o usuário não está autenticado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário não autenticado.')),
        );
      }
    } catch (e) {
      // Tratar erros ao enviar mensagem ou adicionar ao Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar mensagem: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help and Support',
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color:Color.fromARGB(255, 117, 85, 18)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Need Assistance?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showContactForm = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.help, size: 40, color: Theme.of(context).colorScheme.secondary),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Contact us',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color:Theme.of(context).colorScheme.secondary
                            )
                          ),
                          Text(
                            'Send us an email',
                            style:  Theme.of(context).textTheme.displaySmall!.copyWith(
                                color:Theme.of(context).colorScheme.secondary
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (_showContactForm) ...[
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Describe your issue here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendEmailAndAddToFirestore,
                  child: Text('Send'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
