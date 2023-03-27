import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:wall_print_ai_web/ui_components/image_picker_button.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Pick an image of your room'),
              ],
            ),
            GestureDetector(
              onTap: selectFile,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ImagePickerButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectFile() async {
    final bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
  }
}
