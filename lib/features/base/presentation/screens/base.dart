import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/features/cart/presentation/screens/cart.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/homepage.dart';

import '../../../user profile/presentation/screens/user_profile.dart';
import '../../../wishlist/presentation/screens/wishlist.dart';

class Base extends StatefulWidget {
  final int pageIndex;
  const Base({super.key, this.pageIndex = 0});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  final screens = [
    const HomeScreen(),
    const Wishlist(),
    const CartScreen(),
    const UserProfile(),
  ];
  @override
  void initState() {
    super.initState();
    page = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: page,
        items: <Widget>[
          _buildNavItem(0, CupertinoIcons.home, "Home"),
          _buildNavItem(1, CupertinoIcons.heart, "Wishlist"),
          _buildNavItem(2, CupertinoIcons.cart, "Cart"),
          _buildNavItem(3, CupertinoIcons.person, "Profile"),
        ],
        color: primaryColor4,
        buttonBackgroundColor: primaryColor4,
        backgroundColor: Colors.transparent,
        height: 70, // Adjust height for a better layout with 3 items
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: screens[page],
    );
  }

  /// Build Navigation Bar Item with Conditional Label Visibility
  Widget _buildNavItem(int index, IconData icon, String label) {
    return SizedBox(
      height: 50, // Adjust height for better alignment
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25, // Increase size slightly for better visibility
            color: page == index ? primaryColor : primaryColor,
          ),
          if (page != index) // Show label only if the item is not selected
            Text(
              label,
              style: TextStyle(fontSize: 12, color: primaryColor),
            ),
        ],
      ),
    );
  }
}
