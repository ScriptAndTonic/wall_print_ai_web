import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/size_config.dart';
import 'package:wall_print_ai_web/pages/wizard/splash/splash_screen.dart';
import 'package:wall_print_ai_web/pages/wizard/image_picker_page.dart';
import 'package:wall_print_ai_web/pages/wizard/results_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(initialPage: 0);
  Uint8List? roomImageBytes;

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
          setImageBytes: (bytes) => updateRoomImageBytes(bytes),
          onNext: navigateToNextPage,
          onBack: navigateToPrevPage,
        ),
        ResultsPage(
          getRoomImageBytes: () => roomImageBytes,
          onBack: navigateToPrevPage,
        )
      ],
    );
  }

  void updateRoomImageBytes(Uint8List? bytes) {
    if (bytes != null) {
      roomImageBytes = bytes;
      debugPrint('Room image was set');
    }
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
