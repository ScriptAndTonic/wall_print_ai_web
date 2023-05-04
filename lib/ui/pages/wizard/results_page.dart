import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/constants.dart';
import 'package:wall_print_ai_web/http_helper/backend_client.dart';
import 'package:wall_print_ai_web/size_config.dart';
import 'package:wall_print_ai_web/ui/ui_components/custom_submit_button.dart';

class ResultsPage extends StatefulWidget {
  final Uint8List? Function() getRoomImageBytes;
  final VoidCallback onBack;
  const ResultsPage(
      {Key? key, required this.getRoomImageBytes, required this.onBack})
      : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                        'Here are some results',
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
                child: FutureBuilder(
                  future: loadImages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 270.0,
                          viewportFraction: 1,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 60.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 10,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          child: Image.network(snapshot.data![itemIndex]),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSubmitButton(
                      press: () {},
                      text: 'Customize',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<String>> loadImages() async {
    var roomImageBytes = widget.getRoomImageBytes();
    if (roomImageBytes != null) {
      var uploadedImageId = await BackendClient.uploadImage(roomImageBytes!);
      var generationInfo =
          await BackendClient.generateImages(uploadedImageId: uploadedImageId);
      imageUrls.addAll(generationInfo.imageUrls);
      return imageUrls;
    } else {
      debugPrint('Room image was null');
      return imageUrls;
    }
  }

  // Future<List<String>> loadImages() async {
  //   final urls = [
  //     'https://img.freepik.com/free-vector/retro-geometric-shape-sticker-simple-colorful-clipart-vector-set_53876-156397.jpg?w=512',
  //     'https://img.freepik.com/free-vector/retro-geometric-shape-sticker-simple-colorful-clipart-vector-set_53876-156397.jpg?w=512',
  //     'https://img.freepik.com/free-vector/retro-geometric-shape-sticker-simple-colorful-clipart-vector-set_53876-156397.jpg?w=512',
  //     'https://img.freepik.com/free-vector/retro-geometric-shape-sticker-simple-colorful-clipart-vector-set_53876-156397.jpg?w=512',
  //   ];
  //   return List.from(urls);
  // }
}
