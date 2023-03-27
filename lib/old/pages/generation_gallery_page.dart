
import 'package:flutter/material.dart';
import '../components/generated_gallery.dart';

class GenerationGalleryPage extends StatelessWidget {
  final List<String> urls;
  const GenerationGalleryPage({Key? key, required this.urls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wall Print AI'),
        backgroundColor: Colors.blue,
      ),
      body: GeneratedGallery(urls: urls),
    );
  }
}
