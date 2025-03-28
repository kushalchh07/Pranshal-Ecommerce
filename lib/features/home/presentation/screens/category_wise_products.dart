import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/category_product_bloc/categoryproduct_bloc.dart';

import '../blocs/brandproduct_bloc/brandproduct_bloc.dart';
import 'product_details.dart';

class CategoryWiseProducts extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  const CategoryWiseProducts(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  State<CategoryWiseProducts> createState() => _CategoryWiseProductsState();
}

class _CategoryWiseProductsState extends State<CategoryWiseProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CategoryproductBloc>(context)
        .add(FetchCategoryProduct(categoryId: widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: BlocBuilder<CategoryproductBloc, CategoryproductState>(
        builder: (context, state) {
          if (state is CategoryProductLoaded) {
            return state.categoryProducts.length > 0
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: state.categoryProducts.length,
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
                                Get.to(() => ProductDetailPage(
                                      product: state.categoryProducts[index],
                                    ));
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
                                          state.categoryProducts[index]
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
                                        state.categoryProducts[index]
                                            .productName,
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
                                            "Rs.${state.categoryProducts[index].sellPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Normal Price (with strikethrough)
                                          Text(
                                            "Rs.${state.categoryProducts[index].normalPrice.toStringAsFixed(2)}",
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
          if (state is CategoryproductLoading) {
            return const CupertinoActivityIndicator();
          }
          if (state is CategoryproductError) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CategoryproductBloc>(context).add(
                          FetchCategoryProduct(categoryId: widget.categoryId));
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
