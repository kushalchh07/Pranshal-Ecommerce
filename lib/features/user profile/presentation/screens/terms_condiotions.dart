import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../../core/constants/colors.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    final headingStyle = TextStyle(
      fontSize: Get.height * 0.022,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    final bodyStyle = TextStyle(
      fontSize: Get.height * 0.018,
      height: 1.6,
      color: Colors.black87,
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
          "Terms & Conditions",
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
                const SizedBox(height: 16),
                _buildSection("Acceptance of Terms", bodyStyle, headingStyle,
                    "By accessing or using the Pranchal Fashion Store app or website, you agree to be bound by these Terms and Conditions. If you do not agree, please refrain from using our platform."),
                _buildSection("Eligibility", bodyStyle, headingStyle,
                    "You must be at least 16 years old to place orders or create an account on our platform."),
                _buildSection("Account Registration", bodyStyle, headingStyle,
                    "Creating an account allows you to track your orders, save wishlists, and receive special offers. You are responsible for maintaining the confidentiality of your login credentials."),
                _buildSection("Product Information", bodyStyle, headingStyle,
                    "We strive to ensure all product descriptions, images, and prices are accurate. However, we do not warrant that product details are error-free, complete, or current."),
                _buildSection("Orders & Payments", bodyStyle, headingStyle,
                    "Orders are confirmed upon successful payment. We accept various payment methods including cards, digital wallets, and cash on delivery where available."),
                _buildSection("Pricing", bodyStyle, headingStyle,
                    "All prices listed are inclusive of applicable taxes unless stated otherwise. Prices may change without prior notice."),
                _buildSection("Shipping & Delivery", bodyStyle, headingStyle,
                    "We aim to deliver your order promptly. Estimated delivery times are provided at checkout and may vary by location."),
                _buildSection("Returns & Exchanges", bodyStyle, headingStyle,
                    "You can request a return or exchange within 7 days of delivery if the item is unworn, unused, and in original packaging. Please refer to our return policy for details."),
                _buildSection("Refund Policy", bodyStyle, headingStyle,
                    "Refunds are processed once the returned items pass inspection. Refund timelines may vary based on payment method."),
                _buildSection("Cancellation Policy", bodyStyle, headingStyle,
                    "Orders can be cancelled before they are dispatched. Once shipped, cancellation is not possible."),
                _buildSection("Intellectual Property", bodyStyle, headingStyle,
                    "All content on the Pranchal platform, including images, text, logos, and designs, is the property of Pranchal and protected by copyright laws."),
                _buildSection("User Conduct", bodyStyle, headingStyle,
                    "Users must not misuse the app or engage in illegal, harassing, or fraudulent activity. Such actions may result in account suspension."),
                _buildSection(
                    "Limitation of Liability",
                    bodyStyle,
                    headingStyle,
                    "Pranchal shall not be liable for any indirect or consequential loss or damage arising out of your use of our services."),
                _buildSection("Modifications to Terms", bodyStyle, headingStyle,
                    "We reserve the right to update or change these Terms and Conditions at any time. Updates will be posted on this page."),
                _buildSection("Third-Party Services", bodyStyle, headingStyle,
                    "Our platform may use third-party tools or payment gateways. We are not responsible for the privacy or functionality of third-party services."),
                _buildSection("Privacy Policy", bodyStyle, headingStyle,
                    "Your use of our platform is also subject to our Privacy Policy, which explains how we collect, use, and safeguard your data."),
                _buildSection("Contact Us", bodyStyle, headingStyle,
                    "For any queries or concerns regarding these Terms, please contact our support team via the Help section of the app or website."),
                _buildSection("Governing Law", bodyStyle, headingStyle,
                    "These Terms are governed by the laws of Nepal. Any disputes will be resolved under the jurisdiction of Nepalese courts."),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "© 2025 Pranchal Fashion Store",
                    style: bodyStyle.copyWith(
                        fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, TextStyle bodyStyle,
      TextStyle headingStyle, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headingStyle),
          const SizedBox(height: 6),
          Text(content, style: bodyStyle),
        ],
      ),
    );
  }
}
