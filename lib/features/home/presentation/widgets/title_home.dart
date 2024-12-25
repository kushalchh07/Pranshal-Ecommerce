import 'package:flutter/cupertino.dart';

import '../../../../core/constants/colors.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  const HomeTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Text(title,
          style: TextStyle(
              color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}
