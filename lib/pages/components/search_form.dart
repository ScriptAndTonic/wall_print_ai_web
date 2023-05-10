import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/http_helper/backend_client.dart';
import 'package:wall_print_ai_web/pages/wizard/generation_gallery_page.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  SearchFormState createState() {
    return SearchFormState();
  }
}

class SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final promptController = TextEditingController();
  String uploadedFileId = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: promptController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text('Select image'),
            ),
          ),
          Visibility(
            visible: uploadedFileId.isNotEmpty,
            child: const Icon(Icons.check_box),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  generateImages(context);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> generateImages(context) async {
    var generationInfo = await BackendClient.generateImages(
        prompt: promptController.text, uploadedImageId: uploadedFileId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GenerationGalleryPage(urls: generationInfo.imageUrls),
      ),
    );
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );
    if (result?.files.first != null) {
      var bytes = result?.files.first.bytes;
      var uploadedFileId = await BackendClient.uploadImage(bytes!);
      setState(() {
        this.uploadedFileId = uploadedFileId;
      });
    }
  }
}
