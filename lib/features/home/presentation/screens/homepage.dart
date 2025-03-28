import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/home_bloc/home_page_bloc.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/all_categories.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/search_products.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/shimmer.dart';
import 'package:pranshal_ecommerce/features/home/presentation/widgets/home_category.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_brands.dart';
import '../widgets/home_flashsale.dart';
import '../widgets/home_products.dart';
import '../widgets/recommended_for_you.dart';
import '../widgets/title_home.dart';
import 'package:badges/badges.dart' as badges;
import 'all_brands.dart';
import 'all_products.dart';

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
            backgroundColor: primaryColor4,
            automaticallyImplyLeading: false,
            surfaceTintColor: primaryColor4,
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
                  Get.offAll(() => const ProductSearchPage());
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
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor, // Change the border color
                      width: 1.5, // Change the border width
                    ),
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red, // Change the error border color
                      width: 1.5, // Change the error border width
                    ),
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
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
                                onTap: () {},
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
                padding: const EdgeInsets.only(right: 10.0, left: 6),
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
                        Icons.notifications_none_rounded,
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
          body: RefreshIndicator.adaptive(
            color: primaryColor,
            onRefresh: () async {
              BlocProvider.of<HomePageBloc>(context).add(HomePageLoadEvent());
            },
            child: BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                if (state is HomePageInitial) {
                  BlocProvider.of<HomePageBloc>(context)
                      .add(HomePageLoadEvent());
                }
                if (state is HomePageLoading) {
                  return const Center(
                    child: ShimmerHome(),
                  );
                }
                if (state is HomePageLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          const HomeBanner(),
                          state.homeResponse.recommendedProducts.isEmpty
                              ? const SizedBox()
                              : const HomeTitle(
                                  title: 'Recommended For You',
                                  viewAllNeeded: false,
                                  fontSize: 24,
                                ),
                          state.homeResponse.recommendedProducts.isEmpty
                              ? const SizedBox()
                              : RecommendedForYou(
                                  recommendedForYou:
                                      state.homeResponse.recommendedProducts,
                                ),
                          state.homeResponse.flashSaleProducts.isEmpty
                              ? const SizedBox()
                              : const HomeTitle(
                                  title: 'Flash Sale',
                                  viewAllNeeded: false,
                                  fontSize: 24,
                                ),
                          state.homeResponse.flashSaleProducts.isEmpty
                              ? const SizedBox()
                              : HomeFlashSale(
                                  flashSale:
                                      state.homeResponse.flashSaleProducts,
                                ),
                          state.homeResponse.brands.isEmpty
                              ? const SizedBox()
                              : HomeTitle(
                                  title: 'Brands',
                                  viewAllNeeded: true,
                                  onTap: () {
                                    Get.to(() => AllBrands(
                                          homebrands: state.homeResponse.brands,
                                        ));
                                  },
                                ),
                          state.homeResponse.brands.isEmpty
                              ? const SizedBox()
                              : HomeBrands(
                                  homebrands: state.homeResponse.brands,
                                ),
                          state.homeResponse.products.isEmpty
                              ? const SizedBox()
                              : HomeTitle(
                                  title: 'Curated For You',
                                  viewAllNeeded: true,
                                  onTap: () {
                                    Get.to(() => AllProducts(
                                          curatedProducts:
                                              state.homeResponse.products,
                                        ));
                                  },
                                ),
                          state.homeResponse.products.isEmpty
                              ? const SizedBox()
                              : CuratedProduct(
                                  curatedProducts: state.homeResponse.products,
                                ),
                          state.homeResponse.categories.isEmpty
                              ? const SizedBox()
                              : HomeTitle(
                                  title: 'Shop By Categories',
                                  viewAllNeeded: true,
                                  onTap: () {
                                    Get.to(() => AllCategories(
                                          categories:
                                              state.homeResponse.categories,
                                        ));
                                  },
                                ),
                          state.homeResponse.categories.isEmpty
                              ? const SizedBox()
                              : HomeCategory(
                                  categories: state.homeResponse.categories,
                                ),
                          const SizedBox(
                            height: 200,
                          )
                        ]),
                  );
                }
                if (state is HomePageError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Something went wrong!"),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomePageBloc>(context)
                                .add(HomePageLoadEvent());
                          },
                          child: const Text("Retry."))
                    ],
                  );
                }
                return Center(
                  child: CupertinoActivityIndicator(
                    color: primaryColor,
                  ),
                );
              },
            ),
          )),
    );
  }
}
