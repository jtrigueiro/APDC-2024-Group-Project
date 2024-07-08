import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Use'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text(
                'Last Updated: [17-06-2024]',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                    '   Welcome to EcoDine, a restaurant reservation application ("App"). '
                    'By using our App, you agree to comply with and be bound by the following Terms of Use. '),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Please review them carefully.',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.error),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('1. Acceptance of Terms'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        'By accessing or using our App, you agree to be bound by these Terms of Use and our Privacy Policy.'
                        'If you do not agree with any part of these terms, you must not use our App.',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  const Text('2. Changes to Terms'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        'We reserve the right to modify these Terms of Use at any time. '
                        'Any changes will be effective immediately upon posting on the App.'
                        ' Your continued use of the App after changes have been posted will constitute your acceptance of the revised terms.',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  const Text('3. User Accounts'),
                  const Text('3.1. Account Creation'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        'To use certain features of the App, you must register for an account and provide accurate, current, '
                        'and complete information. You are responsible for maintaining the confidentiality of your account '
                        'information and for all activities that occur under your account.',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  const Text(' 3.2. Account Termination'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        'We reserve the right to terminate your account or restrict your access to the App at any time, '
                        'without notice or liability, for any reason, including if we believe you have violated these Terms of Use.',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  const Text('4. Reservations'),
                  const Text('4.1. Making Reservations'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "You can use the App to make reservations at participating restaurants. "
                        "Each reservation is subject to the restaurant's availability and terms.",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Text('4.2. Changes and Cancellations'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "You can modify or cancel your reservations through the App, subject to the restaurant's cancellation policy. "
                        "Failure to comply with the cancellation policy may result in charges or penalties.",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Text('5. User Conduct'),
                  const Text('5.1. Prohibited Activities'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text("You agree not to:\n"
                        "   - Use the App for any unlawful purpose. \n"
                        "   - Post or transmit any content that is harmful, offensive, or otherwise objectionable.\n "
                        "   - Interfere with or disrupt the App or servers or networks connected to the App.\n "
                        "   - Attempt to gain unauthorized access to any portion of the App or any other accounts, systems, or networks connected to the App."
                        ,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Text(' 5.2. User Content'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "You are responsible for any content you post on the App, including reviews and ratings. You grant us a non-exclusive, royalty-free, perpetual, and worldwide license to use, reproduce, modify, and distribute your content.",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),


                  const Text('6. Intellectual Property'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "All content and materials on the App, including text, graphics, logos, and software,are the property of Dynamic Group "
                            "or its licensors and are protected by intellectual property laws. "
                            "You may not use, reproduce, or distribute any content from the App without our express written permission.",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Text('7. Disclaimers'),
                  const Text('7.1. Warranty Disclaimer'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        'The App is provided on an "as is" and "as available" basis without warranties of any kind, either express or implied. '
                            'We do not warrant that the App will be uninterrupted or error-free.',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Text('7.2. Liability Disclaimer'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "In no event shall Dynamic Group be liable for any indirect, incidental, special, or consequential damages arising out "
                            "of or in connection with your use of the App.",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Text('8. Indemnification'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "You agree to indemnify, defend, and hold harmless Dynamic Group and its affiliates, officers, directors, "
                            "employees, and agents from and against any claims, liabilities, damages, losses, and expenses arising out "
                            "of or in any way connected with your use of the App or your violation of these Terms of Use.",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Text('9. Governing Law'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "These Terms of Use shall be governed by and construed in accordance with the laws of [Portugal/Lisbon], "
                            "without regard to its conflict of law principles.",
                        style: Theme.of(context).textTheme.titleSmall),

                  ),

                  const Text('10. Contact Information'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        "If you have any questions about these Terms of Use, please contact us at:\n"
                            "   - Email: [ecodine@company.com] \n"
                            "   - Address: [Lisbon,Portugal] \n",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),

                  const Center(
                    child: Text('EcoDine',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Center(
                    child: Text('Dynamic Group',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
