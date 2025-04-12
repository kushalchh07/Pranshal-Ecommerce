import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../../core/constants/colors.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    final TextStyle headingStyle = TextStyle(
      fontSize: Get.height * 0.025,
      fontWeight: FontWeight.bold,
    );

    final TextStyle bodyStyle = TextStyle(
      fontSize: Get.height * 0.018,
      height: 1.5,
    );
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        surfaceTintColor: appBackgroundColor,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            )),
        title: Text(
          "Privacy Policy",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          thickness: 4,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Last updated: April 10, 2025", style: bodyStyle),
                const SizedBox(height: 20),
                Text("Introduction", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "Welcome to our Clothing App. This Privacy Policy explains how we collect, use, and protect your personal information when you shop with us. By using our app, you agree to the terms outlined below.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Information We Collect", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "We may collect personal details including your name, email, shipping address, phone number, payment information, and browsing activity. This helps us provide a smooth and personalized shopping experience.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("How We Use Your Information", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "Your information is used to:\n"
                  "- Process and deliver your orders\n"
                  "- Provide customer support and updates\n"
                  "- Recommend relevant products\n"
                  "- Analyze user trends to improve our app",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Sharing of Information", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "We do not sell your personal information. However, we may share data with:\n"
                  "- Shipping and logistics providers\n"
                  "- Payment gateways to process transactions\n"
                  "- Marketing platforms (only with your consent)\n"
                  "- Legal authorities when required by law",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Data Security", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "We take data protection seriously and use encryption, firewalls, and secure servers to protect your personal data. Despite our efforts, no system is completely foolproof, so we advise strong password practices.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Your Rights & Choices", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "You can view, edit, or delete your profile anytime. You can also unsubscribe from marketing emails or request data deletion by contacting us.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Cookies & Tracking", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "We may use cookies to remember your preferences and track your activity to enhance your shopping experience. You can disable cookies in your browser settings if preferred.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Children’s Privacy", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "Our app is not intended for children under 13. We do not knowingly collect personal data from minors. If we find such information, it will be deleted immediately.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Policy Changes", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "We may update this policy occasionally. Any changes will be reflected on this page. Continued use of the app after updates means you accept the revised policy.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 20),
                Text("Contact Us", style: headingStyle),
                const SizedBox(height: 10),
                Text(
                  "For questions or concerns regarding this policy, contact our support team:\n\n"
                  "📧 Email: support@pranshalecommerce.com\n",
                  style: bodyStyle,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "© 2025 Your Clothing App",
                    style: bodyStyle.copyWith(fontSize: 14, color: Colors.grey),
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
