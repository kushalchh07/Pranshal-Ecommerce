import 'package:flutter/material.dart';
import 'package:introduction_slider/source/presentation/pages/introduction_slider.dart';
import 'package:introduction_slider/source/presentation/widgets/buttons.dart';
import 'package:introduction_slider/source/presentation/widgets/dot_indicator.dart';
import 'package:introduction_slider/source/presentation/widgets/introduction_slider_item.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/features/authentication/presentation/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      showStatusBar: true,
      items: [
        IntroductionSliderItem(
          logo: Image.asset("assets/images/s4.jpg"),
          title: const Text("Title 1"),
          backgroundColor: whiteColor,
        ),
        IntroductionSliderItem(
          logo: Image.asset("assets/images/s10.jpg"),
          title: const Text("Title 2"),
          backgroundColor: whiteColor,
        ),
        IntroductionSliderItem(
          logo: Image.asset("assets/images/s11.jpg"),
          title: const Text("Title 3"),
          backgroundColor: whiteColor,
        ),
      ],
      done: const Done(
        child: Icon(Icons.done),
        home: LoginScreen(),
      ),
      next: const Next(child: Icon(Icons.arrow_forward)),
      back: const Back(child: Icon(Icons.arrow_back)),
      dotIndicator: const DotIndicator(),
    );
  }
}
