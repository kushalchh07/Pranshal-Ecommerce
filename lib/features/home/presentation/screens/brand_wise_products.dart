import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../blocs/brandproduct_bloc/brandproduct_bloc.dart';

class BrandWiseProducts extends StatefulWidget {
  final String brandName;
  final int brandId;
  const BrandWiseProducts(
      {super.key, required this.brandName, required this.brandId});

  @override
  State<BrandWiseProducts> createState() => _BrandWiseProductsState();
}

class _BrandWiseProductsState extends State<BrandWiseProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BrandproductBloc>(context)
        .add(FetchBrandProductEvent(brandId: widget.brandId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandName),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: BlocBuilder<BrandproductBloc, BrandproductState>(
        builder: (context, state) {
          if (state is BrandproductLoaded) {
            return state.brandProducts.length > 0
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: state.brandProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two items per row
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio:
                                0.75, // Adjust height/width ratio of items
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Get.to(() => ProductDetailPage());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(7),
                                        ),
                                        child: Image.network(
                                          state.brandProducts[index]
                                              .productThumbnail,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Product Name
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        state.brandProducts[index].productName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // Pricing Information
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          // Sell Price
                                          Text(
                                            "Rs.${state.brandProducts[index].sellPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Normal Price (with strikethrough)
                                          Text(
                                            "Rs.${state.brandProducts[index].normalPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("No Product Found"),
                  );
          }
          if (state is BrandproductLoading) {
            return const CupertinoActivityIndicator();
          }
          if (state is BrandproductError) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BrandproductBloc>(context)
                          .add(FetchBrandProductEvent(brandId: widget.brandId));
                    },
                    child: const Text("Try Again")),
                const Text(" Something Went Wrong"),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
