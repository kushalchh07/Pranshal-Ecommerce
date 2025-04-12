import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../../core/constants/colors.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({super.key});

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: Get.height * 0.025,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    );

    final sectionTitleStyle = TextStyle(
      fontSize: Get.height * 0.022,
      fontWeight: FontWeight.w600,
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
          ),
        ),
        title: Text(
          "About Us",
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          radius: const Radius.circular(8),
          thickness: 4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pranchal – The Fashion Destination", style: titleStyle),
                const SizedBox(height: 12),
                Text(
                  "Pranchal is your one-stop destination for trendy, high-quality clothing across all styles and categories. From elegant ethnic wear to edgy street fashion, we curate the best from national and international brands to suit every personality and occasion. "
                  "Whether you're looking for casual wear, formal outfits, gym essentials, party looks, or seasonal styles, Pranchal ensures you’re always fashion-forward.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text("Our Mission", style: sectionTitleStyle),
                const SizedBox(height: 8),
                Text(
                  "Our mission is to redefine your wardrobe with fashion that fits every lifestyle. At Pranchal, we believe everyone deserves access to stylish, comfortable, and durable clothing—without compromising on affordability or authenticity.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                Text("Why Shop With Us?", style: sectionTitleStyle),
                const SizedBox(height: 8),
                _buildBullet(
                    "A wide variety of branded clothing for men, women, and kids"),
                _buildBullet(
                    "Shop by categories: ethnic, western, activewear, formals & more"),
                _buildBullet("Genuine products from trusted fashion brands"),
                _buildBullet(
                    "Affordable pricing with frequent offers and discounts"),
                _buildBullet(
                    "Seamless shopping experience with easy returns and exchanges"),
                _buildBullet(
                    "Exclusive seasonal collections and limited editions"),
                _buildBullet(
                    "Customer-first service with a passion for fashion"),
                const SizedBox(height: 24),
                Text(
                  "With Pranchal, you don't just wear clothes – you wear confidence. We’re proud to be a trusted name in fashion, offering an ever-evolving collection that keeps you ahead in style. Come, discover your fashion journey with us today.",
                  style: bodyStyle,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "© 2025 Pranchal Fashion Store",
                    style: bodyStyle.copyWith(
                      fontSize: 13,
                      color: Colors.grey[600],
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

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: Get.height * 0.018,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
