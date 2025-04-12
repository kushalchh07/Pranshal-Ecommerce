import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/shimmer.dart';

import '../../../../core/constants/colors.dart';
import '../../../base/presentation/screens/base.dart';
import '../blocs/product_bloc/product_bloc.dart';
import 'product_details.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor4,
          automaticallyImplyLeading: false,
          surfaceTintColor: primaryColor4,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Get.offAll(() => const Base(
                    pageIndex: 0,
                  ));
            },
            icon: Icon(
              CupertinoIcons.back,
              color: primaryColor,
            ),
          ),
          title: SizedBox(
            height: 40,
            width: Get.width * 0.8,
            child: TextFormField(
              autofocus: true,
              controller: _searchController,
              onChanged: (query) {
                context
                    .read<ProductBloc>()
                    .add(ProductSearchEvent(query: query));
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
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return const ShimmerHome();
                    }
                    if (state is ProductErrorState) {
                      return Center(child: Text('Error: ${state.error}'));
                    }
                    if (state is ProductLoadedState) {
                      if (state.products.isEmpty) {
                        return const Center(child: Text('No products found'));
                      }
                      return ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => ProductDetailPage(
                                    product: product,
                                  ));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Product Thumbnail
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      color: primaryColor4.withOpacity(0.1),
                                      child: product.productThumbnail != null &&
                                              product
                                                  .productThumbnail.isNotEmpty
                                          ? Image.network(
                                              product.productThumbnail,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Icon(
                                                  Icons
                                                      .image_not_supported_outlined,
                                                  color: primaryColor
                                                      .withOpacity(0.3),
                                                  size: 40,
                                                );
                                              },
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: primaryColor,
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            )
                                          : Icon(
                                              Icons.image_outlined,
                                              color:
                                                  primaryColor.withOpacity(0.3),
                                              size: 40,
                                            ),
                                    ),
                                  ),
                                  // Product Details
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.productName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontFamily: 'inter',
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            product.productDescription,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                              fontFamily: 'inter',
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          // Product Price
                                          Text(
                                            "Rs.${product.sellPrice.toString()}",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: 'inter',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text('No products found'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
