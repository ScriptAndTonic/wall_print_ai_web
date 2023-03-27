import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/pages/wizard/image_picker_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      children: const [ImagePickerPage()],
    );
  }
}
