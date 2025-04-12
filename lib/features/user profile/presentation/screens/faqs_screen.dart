import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/colors.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      "question": "How do I add a new product to the inventory?",
      "answer":
          "To add a new product, go to the 'Inventory' tab, tap the '+' button, and fill in the product details including name, price, stock quantity, and category. Don't forget to save!"
    },
    {
      "question": "Can I track sales by category?",
      "answer":
          "Yes. Navigate to the 'Reports' section, and you’ll find detailed breakdowns by category, date range, and even staff-wise sales summaries."
    },
    {
      "question": "How do I manage returns and exchanges?",
      "answer":
          "Go to the 'Orders' tab, find the specific order, and use the 'Return/Exchange' option. You can update the stock accordingly and issue refunds or replacements."
    },
    {
      "question": "Is there a way to set discount offers?",
      "answer":
          "Yes, under the 'Promotions' section, you can create custom discount codes or set automatic discounts for specific products or collections."
    },
    {
      "question": "Can multiple users access the system?",
      "answer":
          "Absolutely! You can add team members from the 'Settings > Users' section and assign them roles like Admin, Manager, or Sales Staff with different access levels."
    },
    {
      "question": "How do I generate a daily sales report?",
      "answer":
          "Head over to 'Reports', then choose 'Daily Sales'. Select the date and download or print a detailed report including payment methods and sold items."
    },
    {
      "question": "Does the system work offline?",
      "answer":
          "Basic functions like order creation and inventory lookup can work offline. Data syncs automatically when you’re back online."
    },
    {
      "question": "How can I get support if I face any issues?",
      "answer":
          "You can reach our support team from 'Settings > Help & Support', or email us directly at support@fashionmanager.com. We're here 24/7!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle questionStyle = TextStyle(
      fontSize: Get.height * 0.022,
      fontWeight: FontWeight.w600,
    );

    final TextStyle answerStyle = TextStyle(
      fontSize: Get.height * 0.019,
      color: Colors.grey.shade700,
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
          icon: Icon(Icons.arrow_back_ios, color: primaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "FAQs",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            final item = faqs[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  colorScheme: Theme.of(context)
                      .colorScheme
                      .copyWith(primary: primaryColor),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    title: Text(item['question']!, style: questionStyle),
                    children: [
                      Text(item['answer']!, style: answerStyle),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
