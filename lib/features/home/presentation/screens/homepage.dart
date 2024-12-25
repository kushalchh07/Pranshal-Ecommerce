import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pranshal_ecommerce/features/home/presentation/widgets/home_category.dart';

import '../../../../core/constants/colors.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_flashsale.dart';
import '../widgets/title_home.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(CupertinoIcons.bars, color: primaryColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              ),
            ),
            title: SizedBox(
              height: 40,
              child: TextFormField(
                autofocus: false,
                controller: _searchController,
                onTap: () {
                  // Navigate to the search page or handle search
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    size: 22,
                    color: dreamGrey,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'inter'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor, // Change the border color
                      width: 1.5, // Change the border width
                    ),
                    borderRadius: BorderRadius.circular(7.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor, // Change the border color
                      width: 1.5, // Change the border width
                    ),
                    borderRadius: BorderRadius.circular(7.0), // Rounded corners
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red, // Change the error border color
                      width: 1.5, // Change the error border width
                    ),
                    borderRadius: BorderRadius.circular(7.0), // Rounded corners
                  ),
                  contentPadding: EdgeInsets.zero,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _searchController.clear();
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _searchController.text.isNotEmpty &&
                                _searchController.text != ''
                            ? GestureDetector(
                                onTap: () {
                                  _searchController.text == ''
                                      ? null
                                      : {
                                          _searchController.clear(),
                                          FocusScope.of(context).unfocus(),
                                        };
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              )
                            : const SizedBox.shrink()),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 2),
                child: GestureDetector(
                  onTap: () {},
                  child: badges.Badge(
                      badgeContent: const Text(
                        "0",
                        style: TextStyle(color: Colors.white),
                      ),
                      showBadge: false,
                      position: badges.BadgePosition.topEnd(top: -7, end: -5),
                      child: Icon(
                        CupertinoIcons.bell,
                        size: 30,
                        color: primaryColor,
                      )),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: const Text(
                    'Drawer Header',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    // Handle navigation to Home
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('Cart'),
                  onTap: () {
                    // Handle navigation to Cart
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    // Handle navigation to Profile
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeBanner(),
                  HomeTitle(
                    title: 'Flash Sale',
                    viewAllNeeded: true,
                    fontSize: 24,
                    onTap: () {},
                  ),
                  const HomeFlashSale(),
                  HomeTitle(
                    title: 'Categories',
                    viewAllNeeded: true,
                    onTap: () {},
                  ),
                  const HomeCategory(),
                ]),
          )),
    );
  }
}
