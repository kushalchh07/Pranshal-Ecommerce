import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../core/constants/colors.dart';

class CustomListTile extends StatelessWidget {
  final String tileName;
  final String? tileIconSVg;
  final Icon? tileIcon;
  final Function? ontap;
  const CustomListTile(
      {super.key,
      required this.tileName,
      this.tileIconSVg,
      this.tileIcon,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap as void Function()?,
      title: Text(
        tileName,
        style: TextStyle(
            color: blackColor,
            fontSize: 16,
            fontFamily: 'inter',
            fontWeight: FontWeight.w400),
      ),
      leading: tileIconSVg == null
          ? Icon(tileIcon!.icon, color: primaryColor)
          : SvgPicture.asset(tileIconSVg ?? "",
              color: primaryColor, height: 20),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: primaryColor,
        size: 15,
      ), // Customize the icon
    );
  }
}
