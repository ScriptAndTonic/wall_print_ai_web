import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/pages/wizard/image_picker_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      children: [
        ImagePickerPage(
          onNext: navigateToNextPage,
        ),
        ImagePickerPage(
          onNext: navigateToNextPage,
        ),
      ],
    );
  }

  navigateToNextPage() {
    controller.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }
}
