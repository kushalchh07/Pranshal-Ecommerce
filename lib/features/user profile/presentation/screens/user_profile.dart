import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/user%20profile/presentation/screens/order_list.dart';
import 'package:pranshal_ecommerce/features/user%20profile/presentation/screens/privacy_policy.dart';
import 'package:pranshal_ecommerce/features/user%20profile/presentation/screens/terms_condiotions.dart';
import 'package:pranshal_ecommerce/features/user%20profile/presentation/widgets/logout_dialog.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/user_data.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../authentication/presentation/screens/login_screen.dart';
import '../../data/widgets/custom_list_tile.dart';
import '../../data/widgets/notification_toggle.dart';
import '../widgets/location_flag_widget.dart';
import 'about_company.dart';
import 'faqs_screen.dart';
import 'my_profile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  StringUtils stringUtils = StringUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor4,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text(
            "My Profile",
            style: TextStyle(color: myBlack, fontWeight: FontWeight.bold),
          ),
          // actions: [
          //   // LocationFlagWidget(),
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       CupertinoIcons.settings,
          //       color: primaryColor,
          //     ),
          //   )
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: userImage == null || userImage == ''
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: whiteColor, width: 1.5),
                              ),
                              child: Center(
                                child: Text(
                                  stringUtils.getFirstandLastNameInitals(
                                      userName.toString().toUpperCase()),
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 16),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              height: 40,
                              width: 40,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: primaryColor, width: 1.5),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              imageUrl: "$userImage",
                              placeholder: (context, url) => Image.asset(
                                'assets/others/no-image.png',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/others/no-image.png',
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back, $userName !",
                          style: const TextStyle(
                              fontFamily: "inter",
                              fontWeight: FontWeight.w400,
                              fontSize: 24),
                        ),
                        Text(
                          userEmail,
                          style: const TextStyle(
                              fontFamily: "inter", fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Personal Information',
                  style: TextStyle(
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                CustomListTile(
                  tileName: 'Profile',
                  tileIcon: Icon(CupertinoIcons.person_crop_circle),
                  ontap: () {
                    Get.to(() => MyProfile());
                  },
                ),
                CustomListTile(
                  tileName: 'Order Details',
                  tileIcon: const Icon(
                    CupertinoIcons.cart,
                  ),
                  ontap: () {
                    Get.to(() => const OrderListScreen(
                          isFromProfile: true,
                        ));
                  },
                ),
                const Text(
                  'General',
                  style: TextStyle(
                      fontFamily: "inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                CustomListTile(
                  tileName: 'About Company',
                  tileIcon: const Icon(
                    Icons.info_outline,
                  ),
                  ontap: () {
                    Get.to(() => const AboutCompany());
                  },
                ),
                CustomListTile(
                  tileName: 'FAQs',
                  tileIconSVg: 'assets/icons/custom_icons/help.svg',
                  ontap: () {
                    Get.to(() => FAQScreen());
                  },
                ),
                CustomListTile(
                  tileName: 'Terms & Conditions',
                  tileIcon: const Icon(
                    Icons.playlist_add_check_circle_outlined,
                  ),
                  ontap: () {
                    Get.to(() => const TermsConditionsScreen());
                  },
                ),
                CustomListTile(
                  tileName: 'Privacy Policy',
                  tileIcon: const Icon(
                    Icons.privacy_tip_outlined,
                  ),
                  ontap: () {
                    Get.to(() => const PrivacyPolicy());
                  },
                ),
                const Text(
                  'Other Actions',
                  style: TextStyle(
                      fontFamily: "inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                CustomListTile(
                  tileName: 'Share App',
                  ontap: () {},
                  tileIconSVg: "assets/icons/custom_icons/share.svg",
                ),
                ListTile(
                  title: Text(
                    'Notification',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400),
                  ),
                  leading:
                      SvgPicture.asset('assets/icons/custom_icons/noti.svg',
                          colorFilter: ColorFilter.mode(
                            primaryColor,
                            BlendMode.srcIn,
                          ),
                          height: 20), // Customize the icon
                  trailing: const NotificationToggle(
                      //this is a custom widget

                      ),
                ),
                CustomListTile(
                  tileName: 'Log Out',
                  ontap: () {
                    showLogoutDialog(context);
                  },
                  tileIcon: const Icon(Icons.logout),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ));
  }
}
