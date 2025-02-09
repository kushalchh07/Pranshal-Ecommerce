import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../../core/constants/colors.dart';
import '../blocs/product_bloc/product_bloc.dart';

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
              Get.back();
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
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductErrorState) {
                      return Center(child: Text('Error: ${state.error}'));
                    }
                    if (state is ProductLoadedState) {
                      return ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ListTile(
                            title: Text(product.productName),
                            subtitle: Text(product.productDescription),
                          );
                        },
                      );
                    }
                    return Center(child: Text('No products found'));
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
