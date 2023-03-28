import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:wall_print_ai_web/ui_components/image_picker_button.dart';

class ImagePickerPage extends StatelessWidget {
  final Function() onNext;
  const ImagePickerPage({Key? key, required this.onNext}) : super(key: key);

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
                Text(
                  'Pick an image of your room',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: selectFile,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ImagePickerButton(),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: onNext,
                    child: const Text('Next'),
                  ),
                ),
              ],
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
