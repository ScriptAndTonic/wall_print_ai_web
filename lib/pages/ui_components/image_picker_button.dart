import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:wall_print_ai_web/constants.dart';
import 'package:wall_print_ai_web/entities/loading_state.dart';
import 'package:wall_print_ai_web/entities/room_image_upload_info.dart';
import 'package:wall_print_ai_web/http_helper/backend_client.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({Key? key}) : super(key: key);

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  LoadingState imageUploadState = LoadingState.open;

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
              children: [
                getAppropriateIcon(),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  getAppropriateIconText(),
                  style: const TextStyle(fontSize: 18, color: kSecondaryColor),
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
      uploadRoomImageBytes(bytesFromPicker);
    }
  }

  Future<void> uploadRoomImageBytes(Uint8List? bytes) async {
    setState(() {
      imageUploadState = LoadingState.loading;
    });
    if (bytes != null) {
      debugPrint('Room image was set');
      RoomImageUploadInfo.lastestUploadedRoomImageId =
          await BackendClient.uploadImage(bytes);
      debugPrint('Room image uploaded');
    }
    setState(() {
      imageUploadState = LoadingState.complete;
    });
  }

  Widget getAppropriateIcon() {
    switch (imageUploadState) {
      case LoadingState.loading:
        {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          );
        }

      case LoadingState.complete:
        {
          return const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          );
        }

      default:
        {
          return const Icon(
            Icons.folder,
            color: kSecondaryColor,
            size: 60,
          );
        }
    }
  }

  String getAppropriateIconText() {
    switch (imageUploadState) {
      case LoadingState.loading:
        {
          return 'Uploading...';
        }
      case LoadingState.complete:
        {
          return 'Done';
        }
      default:
        {
          return 'Select image';
        }
    }
  }
}
