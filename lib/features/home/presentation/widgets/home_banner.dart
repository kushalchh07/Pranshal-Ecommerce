import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({
    super.key,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final _pageController =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
  int currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  List<String> slider = [
    "assets/images/slider_1.png",
    "assets/images/slider_2.png",
    "assets/images/slider_3.png",
    "assets/images/slider_4.png",
  ];
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (currentPage < slider.length - 1) {
        currentPage++;
      } else {
        currentPage = 0; // Go back to the first slide
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Get.height * 0.2,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: slider.length,
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              // log("image url ${sliderUrl + (widget.slider[index].image ?? '')}");
              return Image.asset(
                slider[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(
          height: 15,
          child: DotsIndicator(
            position: currentPage,
            dotsCount: slider.length,
            decorator: DotsDecorator(
              size: const Size.square(8.0),
              activeSize: const Size(52.0, 10.0),
              activeColor: blackColor,
              color: blackColor,
              activeShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                  right: Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
