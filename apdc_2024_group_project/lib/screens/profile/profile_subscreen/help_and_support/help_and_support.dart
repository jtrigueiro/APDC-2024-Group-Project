import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _showContactForm = false;
  final DatabaseService _supportService = DatabaseService();

  Future<void> _sendEmailAndAddToFirestore() async {
    final String body = _controller.text.trim();

    try {
      await _supportService.sendEmailAndAddToFirestore(body);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully! We will get back to you soon!'),
        duration: Duration(seconds: 1),),
      );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error while sending the message: $e'),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Padding(
                padding:const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Need Assistance?',
                  style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showContactForm = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Icon(
                          Icons.help,
                          size: 40,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact us',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          Text(
                            'Send us an email',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (_showContactForm) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: _controller,
                    inputFormatters:  <TextInputFormatter> [
                      LengthLimitingTextInputFormatter(300),],
                    maxLength: 300,
                    decoration: InputDecoration(
                      hintText: 'Describe your issue here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: _sendEmailAndAddToFirestore,
                    child: const Text('Send'),
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
