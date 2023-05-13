import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/constants.dart';
import 'package:wall_print_ai_web/entities/room_image_upload_info.dart';
import 'package:wall_print_ai_web/http_helper/backend_client.dart';
import 'package:wall_print_ai_web/pages/ui_components/custom_icon_button.dart';
import 'package:wall_print_ai_web/size_config.dart';
import 'package:wall_print_ai_web/pages/ui_components/custom_submit_button.dart';

class ResultsPage extends StatefulWidget {
  final VoidCallback onBack;
  const ResultsPage({
    Key? key,
    required this.onBack,
  }) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<Image> imageUrls = [];

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
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'These should fit',
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
                      // if (1 != 1) {
                      return CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 270.0,
                          viewportFraction: 1,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Container(
                          margin: const EdgeInsets.symmetric(horizontal: 60.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          child: snapshot.data![itemIndex],
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                  'assets/images/paint-palette.gif'),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Generating...',
                            style:
                                TextStyle(fontSize: 18, color: kSecondaryColor),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomSubmitButton(
                          press: () {},
                          text: 'Customize',
                        ),
                        const SizedBox(height: 10),
                        CustomIconButton(
                          press: () {},
                          text: 'Buy',
                          icon: Icons.shopping_cart_checkout,
                        ),
                      ],
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

  Future<List<Image>> loadImages() async {
    var generationInfo = await BackendClient.generateImageURLs(
        uploadedImageId: RoomImageUploadInfo.lastestUploadedRoomImageId);
    imageUrls.addAll(generationInfo.imageUrls.map((url) => Image.network(url)));
    return imageUrls;
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
