import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text(
          'Terms of Use',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
          Terms of Use

          Last Updated: [17-06-2024]

            Welcome to EcoDine, a restaurant reservation application ("App"). By using our App, you agree to comply with and be bound by the following Terms of Use. Please review them carefully.

          1. Acceptance of Terms
            By accessing or using our App, you agree to be bound by these Terms of Use and our Privacy Policy. If you do not agree with any part of these terms, you must not use our App.

          2. Changes to Terms
            We reserve the right to modify these Terms of Use at any time. Any changes will be effective immediately upon posting on the App. Your continued use of the App after changes have been posted will constitute your acceptance of the revised terms.

          3. User Accounts
            3.1. Account Creation
            To use certain features of the App, you must register for an account and provide accurate, current, and complete information. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.

            3.2. Account Termination
            We reserve the right to terminate your account or restrict your access to the App at any time, without notice or liability, for any reason, including if we believe you have violated these Terms of Use.

          4. Reservations
            4.1. Making Reservations
            You can use the App to make reservations at participating restaurants. Each reservation is subject to the restaurant's availability and terms.

            4.2. Changes and Cancellations
            You can modify or cancel your reservations through the App, subject to the restaurant's cancellation policy. Failure to comply with the cancellation policy may result in charges or penalties.

          5. User Conduct
            5.1. Prohibited Activities
            You agree not to:
            - Use the App for any unlawful purpose.
            - Post or transmit any content that is harmful, offensive, or otherwise objectionable.
            - Interfere with or disrupt the App or servers or networks connected to the App.
            - Attempt to gain unauthorized access to any portion of the App or any other accounts, systems, or networks connected to the App.

            5.2. User Content
            You are responsible for any content you post on the App, including reviews and ratings. You grant us a non-exclusive, royalty-free, perpetual, and worldwide license to use, reproduce, modify, and distribute your content.

          6. Intellectual Property
            All content and materials on the App, including text, graphics, logos, and software, are the property of Dynamic Group or its licensors and are protected by intellectual property laws. You may not use, reproduce, or distribute any content from the App without our express written permission.

          7. Disclaimers
             7.1. Warranty Disclaimer
            The App is provided on an "as is" and "as available" basis without warranties of any kind, either express or implied. We do not warrant that the App will be uninterrupted or error-free.

             7.2. Liability Disclaimer
            In no event shall Dynamic Group be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your use of the App.

          8. Indemnification
            You agree to indemnify, defend, and hold harmless Dynamic Group and its affiliates, officers, directors, employees, and agents from and against any claims, liabilities, damages, losses, and expenses arising out of or in any way connected with your use of the App or your violation of these Terms of Use.

          9. Governing Law
            These Terms of Use shall be governed by and construed in accordance with the laws of [Portugal/Lisbon], without regard to its conflict of law principles.

          10. Contact Information
            If you have any questions about these Terms of Use, please contact us at:
            - Email: [ecodine@company.com]
            - Address: [Lisbon,Portugal]

            **EcoDine**  
            **Dynamic Group**
            ''',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
