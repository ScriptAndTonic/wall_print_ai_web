import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/constants.dart';
import 'package:wall_print_ai_web/pages/ui_components/custom_submit_button.dart';
import 'package:wall_print_ai_web/pages/ui_components/image_picker_button.dart';
import 'package:wall_print_ai_web/size_config.dart';

class ImagePickerPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const ImagePickerPage({
    Key? key,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  bool roomImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: IconButton(
              iconSize: 40,
              color: kPrimaryColor,
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_upward),
            ),
          ),
          Column(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Pick an image of your room',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(36),
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImagePickerButton(onImageSelected: onImageSelected),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    roomImageSelected
                        ? CustomSubmitButton(
                            press: widget.onNext,
                            text:
                                roomImageSelected ? 'Generate' : 'Surprise me',
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onImageSelected(bool imageSelected) {
    setState(() {
      roomImageSelected = imageSelected;
    });
  }
}
