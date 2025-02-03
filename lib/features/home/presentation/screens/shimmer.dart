import 'package:flutter/cupertino.dart';

class ShimmerHome extends StatefulWidget {
  const ShimmerHome({super.key});

  @override
  State<ShimmerHome> createState() => _ShimmerHomeState();
}

class _ShimmerHomeState extends State<ShimmerHome> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CupertinoActivityIndicator(),
      ],
    );
  }
}
