import 'package:flutter/material.dart';
import 'package:pranshal_ecommerce/features/home/presentation/widgets/home_category.dart';

import '../widgets/home_banner.dart';
import '../widgets/home_flashsale.dart';
import '../widgets/title_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeBanner(),
                HomeTitle(
                  title: 'Categories',
                  viewAllNeeded: true,
                  onTap: () {},
                ),
                const HomeCategory(),
                HomeTitle(
                  title: 'Flash Sale',
                  viewAllNeeded: true,
                  onTap: () {},
                ),
                const HomeFlashSale()
              ]),
        ));
  }
}
