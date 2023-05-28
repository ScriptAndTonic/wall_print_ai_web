import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/size_config.dart';
import 'package:wall_print_ai_web/pages/wizard/splash_screen.dart';
import 'package:wall_print_ai_web/pages/wizard/image_picker_page.dart';
import 'package:wall_print_ai_web/pages/wizard/results_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        SplashScreen(onNext: navigateToNextPage),
        ImagePickerPage(
          onNext: navigateToNextPage,
          onBack: navigateToPrevPage,
        ),
        ResultsPage(
          onBack: navigateToPrevPage,
        )
      ],
    );
  }

  navigateToNextPage() {
    controller.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  navigateToPrevPage() {
    controller.previousPage(
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }
}
