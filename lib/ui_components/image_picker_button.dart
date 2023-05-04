import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:wall_print_ai_web/constants.dart';

class ImagePickerButton extends StatelessWidget {
  final void Function(Uint8List) onImageSelected;
  const ImagePickerButton({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: selectImage,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          dashPattern: const [10, 4],
          strokeCap: StrokeCap.round,
          color: kPrimaryColor,
          child: Container(
            width: 340,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.folder,
                  color: kPrimaryColor,
                  size: 60,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Pick image',
                  style: TextStyle(fontSize: 18, color: kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectImage() async {
    final bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker != null) {
      onImageSelected(bytesFromPicker);
    }
  }
}
