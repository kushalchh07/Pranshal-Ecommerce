import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/features/base/presentation/screens/base.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/homepage.dart';

import '../../../../core/constants/user_data.dart';
import '../../../cart/data/repositories/order_repository.dart';
import '../../../cart/presentation/blocs/fetch_order/fetchorder_bloc.dart';
import 'order_details.dart';

class OrderListScreen extends StatelessWidget {
  final bool isFromProfile;
  const OrderListScreen({
    super.key,
    this.isFromProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchorderBloc(OrderRepository())..add(LoadUserOrdersEvent(userId)),
      child: Scaffold(
        appBar: AppBar(
          leading: isFromProfile
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: myBlack,
                  ),
                  onPressed: () => Get.back(),
                )
              : GestureDetector(
                  onTap: () {
                    Get.offAll(() => const Base(
                          pageIndex: 0,
                        ));
                  },
                  child: const Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 8),
                    child: const Text("Home",
                        style: TextStyle(color: whiteColor, fontSize: 20)),
                  )),
          backgroundColor: isFromProfile ? whiteColor : primaryColor,
        ),
        body: BlocBuilder<FetchorderBloc, FetchorderState>(
          builder: (context, state) {
            if (state is FetchOrderLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchOrderErrorState) {
              return Center(
                  child: Text(state.message,
                      style: const TextStyle(color: Colors.red)));
            } else if (state is FetchOrderLoadedState) {
              if (state.orders.isEmpty) {
                return const Center(child: Text("No orders found!"));
              }
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading:
                          Icon(Icons.shopping_cart, color: Colors.blueAccent),
                      title: Text("Order #${order.orderId}"),
                      subtitle: Text("Status: ${order.orderStatus}"),
                      trailing:
                          Text("Rs.${order.totalAmount.toStringAsFixed(2)}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailScreen(order: order),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("Something went wrong"));
          },
        ),
      ),
    );
  }
}
