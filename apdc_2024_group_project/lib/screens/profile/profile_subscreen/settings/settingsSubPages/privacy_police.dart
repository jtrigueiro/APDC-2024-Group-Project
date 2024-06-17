import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
           Privacy Policy

          Last Updated: [17-06-2024]

            Dynamic Group ("we," "our," "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and share information when you use the EcoDine application ("App").

          1. Information We Collect
             1.1. Personal Information
            We collect personal information that you provide to us, such as your name, email address, phone number, and payment information.

            1.2. Usage Information
            We collect information about your use of the App, including your reservation history, preferences, and interactions with our services.

            1.3. Device Information
            We collect information about the device you use to access the App, including the device type, operating system, and IP address.

          2. How We Use Your Information
            We use the information we collect to:
            - Provide and improve our services.
            - Process your reservations and payments.
            - Communicate with you about your account and our services.
            - Personalize your experience and provide tailored recommendations.
            - Analyze usage patterns and trends to improve the App.

          3. How We Share Your Information
            We may share your information with:
            - Restaurants to process and manage your reservations.
            - Service providers who assist us in operating the App and providing our services.
            - Legal authorities if required by law or to protect our rights and property.

          4. Your Choices
            You have the right to:
            - Access and update your personal information.
            - Opt out of receiving promotional communications.
            - Delete your account and personal information.

          5. Security
            We take reasonable measures to protect your information from unauthorized access, use, or disclosure. However, no data transmission over the internet or storage system can be guaranteed to be 100% secure.

          6. Changes to This Policy
            We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on the App. Your continued use of the App after changes have been posted will constitute your acceptance of the revised policy.

          7. Contact Us
            If you have any questions about this Privacy Policy, please contact us at:
            -  Email: [ecodine@company.com]
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
