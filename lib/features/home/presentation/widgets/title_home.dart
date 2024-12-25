import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final dynamic viewAllNeeded;
  final Function? onTap;
  const HomeTitle(
      {super.key, required this.title, this.viewAllNeeded, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          viewAllNeeded
              ? TextButton(
                  onPressed: onTap as void Function()?,
                  child: Text(
                    'View All',
                    style: TextStyle(color: primaryColor),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
