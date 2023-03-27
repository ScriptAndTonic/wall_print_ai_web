import 'package:flutter/material.dart';
import 'package:gallery_view/gallery_view.dart';

class GeneratedGallery extends StatelessWidget {
  final List<String> urls;

  const GeneratedGallery({Key? key, required this.urls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GalleryView(
      key: UniqueKey(),
      imageUrlList: urls,
      crossAxisCount: 2,
    );
  }
}
