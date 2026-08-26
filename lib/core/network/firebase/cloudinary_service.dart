import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  final dio.Dio _dio = dio.Dio();

  final String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  final String uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

  /// Function to upload an image to Cloudinary and return the secure URL
  /// Throws an Exception with a user-friendly message on failure
  Future<List<String>> uploadMultipleImages(List<XFile> images) async {
    List<String> urls = [];
    for (var image in images) {
      final url = await uploadImage(File(image.path));
      if (url != null) urls.add(url);
    }
    return urls;
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split("/").last;

      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
        "upload_preset": uploadPreset,
      });

      dio.Response response = await _dio.post(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
        data: formData,
      );

      if (response.statusCode == 200) {
        // The Link to the uploaded image is in response.data["secure_url"]
        return response.data['secure_url'];
      }
      return null;
    } catch (error) {
      // Placeholder for handling:
      String errorMessage = "Failed to upload image";
      if (error is dio.DioException) {
        // You can extract more details from DioException if needed
        errorMessage = "Network error during upload: ${error.message}";
      }

      // Throwing an exception with the clear error message so Repo can catch it
      throw Exception(errorMessage);
    }
  }
}
