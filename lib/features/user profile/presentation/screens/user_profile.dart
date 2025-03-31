import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/user%20profile/presentation/screens/order_list.dart';

import '../../../../core/constants/colors.dart';
import '../widgets/location_flag_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
        actions: [
          // LocationFlagWidget(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.settings,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          LocationFlagWidget(),
          const Center(
            child: Text('User Profile Screen'),
          ),
          ListTile(
              onTap: () {
                Get.to(() => const OrderListScreen(isFromProfile: true));
              },
              leading: Icon(
                CupertinoIcons.person,
                color: primaryColor,
              ),
              title: Text(
                'Order list',
                style: TextStyle(color: primaryColor),
              ))
        ],
      ),
    );
  }
}
