import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../entities/generation_info.dart';

class BackendClient {
  // static const baseUrl = 'http://0ab6-141-85-150-238.ngrok.io';
  static const baseUrl = 'https://visualio-backend.herokuapp.com';
  // static const baseUrl = 'http://localhost:3000';

  static Future<GenerationInfo> generateImageURLs(
      {String prompt = '', String uploadedImageId = ''}) async {
    final Map<String, dynamic> queryParams = {};
    if (prompt.isNotEmpty) {
      queryParams['prompt'] = prompt;
    }
    if (uploadedImageId.isNotEmpty) {
      queryParams['uploadedImageId'] = uploadedImageId;
    }

    final dio = Dio();
    final response = await dio.get(
      '$baseUrl/generatePrint',
      queryParameters: queryParams,
    );
    if (response.statusCode == 200) {
      return GenerationInfo.fromJson(response.data);
    } else {
      throw 'Server error';
    }
  }

  static Future<String> uploadImage(Uint8List bytes) async {
    var formData = FormData.fromMap(
      {
        'file': MultipartFile.fromBytes(
          bytes,
          filename: 'image.png',
          contentType: MediaType('image', 'png'),
        )
      },
    );

    final dio = Dio();
    var response = await dio.post(
      '$baseUrl/uploadImage',
      data: formData,
    );
    if (response.statusCode == 200) {
      return response.data['fileId'].toString();
    } else {
      throw 'Server error';
    }
  }
}
