import 'package:draggable_home/draggable_home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_toolkit/flutter_ui_toolkit.dart';
import '../../helpers/camera_preview.dart';
import '../../http_helper/backend_client.dart';
import '../styles/inputs.dart';
import 'generation_gallery_page.dart';

class MainPageOld extends StatefulWidget {
  const MainPageOld({Key? key}) : super(key: key);

  @override
  State<MainPageOld> createState() => _MainPageOldState();
}

class _MainPageOldState extends State<MainPageOld> {
  final promptController = TextEditingController();
  String uploadedFileId = '';
  List<String> imageUrls = ['Test'];
  bool uploadBtnIsLoading = false;
  bool generateBtnIsLoading = false;

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: const Text('Wall Print AI'),
      headerWidget: headerWidget(context),
      body: [
        listView(context),
      ],
      fullyStretchable: true,
      expandedBody: const CameraPreview(),
      backgroundColor: Colors.white,
      appBarColor: Colors.blue,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Wall Print AI',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }

  ListView listView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            textAlign: TextAlign.start,
            controller: promptController,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.blue),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lightbulb, color: Colors.blue),
              hintText: 'Type your ideas...',
              hintStyle: TextStyle(fontSize: 16, color: Colors.blue),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              filled: false,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: UIButton.solid(
            as: solidButtonStyles,
            label: 'Upload an image',
            onPressed: () => {pickImage()},
            borderRadius: 64.0,
            icon: uploadBtnIsLoading
                ? Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Icon(
                    Icons.upload,
                    color: Colors.white,
                    size: 32,
                  ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0),
          child: UIButton.solid(
            as: solidButtonStyles,
            label: 'Generate',
            onPressed: () => {generateImages(context)},
            borderRadius: 64.0,
            icon: generateBtnIsLoading
                ? Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Icon(
                    Icons.format_paint_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
          ),
        ),
      ],
    );
  }

  void pickImage() async {
    setState(() {
      uploadBtnIsLoading = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );
    if (result?.files.first != null) {
      var bytes = result?.files.first.bytes;
      var uploadedFileId = await BackendClient.uploadImage(bytes!);
      setState(() {
        this.uploadedFileId = uploadedFileId;
        uploadBtnIsLoading = false;
      });
    }
  }

  Future<void> generateImages(context) async {
    setState(() {
      generateBtnIsLoading = true;
    });
    var generationInfo = await BackendClient.generateImages(
        prompt: promptController.text, uploadedImageId: uploadedFileId);
    setState(() {
      generateBtnIsLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GenerationGalleryPage(urls: generationInfo.imageUrls),
      ),
    );
  }
}
