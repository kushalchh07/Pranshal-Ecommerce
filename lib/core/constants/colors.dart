import 'package:flutter/material.dart';

class ColorConverter {
  Color hexColor({required dynamic color}) {
    dynamic col = color.replaceAll('#', '0xFF');
    return Color(int.parse(col));
  }

  rgba({required String color}) {}
}

// #273033
// #3A4959
// #607A84
// #97B6C6
// #D7E9F4
// #E8EAE9

ColorConverter convert = ColorConverter();

// Color mainColor = convert.hexColor(color: '#003400');
// Color mainColor = Colors.teal;
Color primaryColor = convert.hexColor(color: '#273033');
Color primaryColor1 = convert.hexColor(color: '#3A4959');

Color primaryColor2 = convert.hexColor(color: '#607A84');

Color primaryColor3 = convert.hexColor(color: '#97B6C6');

Color primaryColor4 = convert.hexColor(color: '#D7E9F4');
Color primaryColor5 = convert.hexColor(color: '#E8EAE9');

const Color secondaryColor =  Color.fromARGB(255, 5, 176, 74);
Color secondaryColorwithOpasity = const Color(0xffFB7393);
Color inputFieldColor = convert.hexColor(color: '#FFFFFF');
Color kgreyColor = const Color(0xFFD9D9D9);
Color kborderColorReview = convert.hexColor(color: '#EAEAEA');
Color questionContainerColor = whiteColor;

// Color appBackgroundColor = const Color.fromARGB(255, 197, 196, 184);
Color appBackgroundColor = const Color.fromARGB(255, 245, 245, 245);
// Color appSecondary = Color.fromARGB(255, 198, 198, 198);
Color appSecondary = Colors.white;
Color lightTextColor = const Color(0xFF403930);
Color darkBackgroundColor = const Color(0xFF2B2B2B);
Color darkTextColor = const Color(0xFFF3F2FF);

Color greyColor = Colors.grey;
Color lightGrey = Colors.grey[200]!;
Color lightBackgroundColor = const Color(0xFFFFFFFF);

Color greyColorDarker = Colors.grey[700]!;
const Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color errorColor = Colors.red;
Color successColor = Colors.green;
Color blueColor = const Color.fromARGB(255, 12, 133, 181);
Color greenColor = const Color.fromARGB(255, 26, 116, 107);
Color browncolor = const Color.fromARGB(255, 194, 94, 58);
Color yellowColor = const Color.fromARGB(255, 198, 163, 47);
// Color blueColor = Color(0xFF0590c7);

const Color mainColor = Color(0xff03ADF1);

const Color dreamGrey = Color(0xff676767);

const starColor = Color(0xffFFB904);

Color myBlue = const Color(0xff03ADF1);
Color myLightBlue = const Color(0xff6BC6EB);
Color myLighterBlue = const Color(0xffD4EBF4);
Color myBlack = const Color(0xff000000);
Color myGrey = const Color(0xff676767);
Color myLightGrey = const Color(0xffADADAD);
Color myLighterGrey = const Color(0xFFDCDCDC);
Color myDarkGreen = const Color(0xff003400);
Color textColor = const Color(0xff003400);
// Color myGreen = const Color(0xff18A55C);
Color myWhite = const Color(0xffFFFFFF);
Color myMainText = const Color.fromARGB(255, 0, 52, 0);
Color myInputBorderColor = const Color.fromARGB(255, 197, 197, 197);

Color myMoneyColor = const Color.fromARGB(255, 24, 162, 92);
