import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:rentora/core/errors/firebase_error_handler.dart';

class CloudinaryService {
  final dio.Dio _dio = dio.Dio();

  // Put your Cloudinary credentials here. You can also use environment variables or a secure storage solution for better security
  final String cloudName = "YOUR_CLOUD_NAME";
  final String uploadPreset = "YOUR_UNSIGNED_UPLOAD_PRESET";

  /// Function to upload an image to Cloudinary and return the secure URL of the uploaded image
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
      // We are using the FirebaseErrorHandler to handle errors and provide user-friendly messages. This is a good practice to ensure that the UI can display clear error messages to the user
      final String errorMessage = FirebaseErrorHandler.handle(error);

      // You can log the error message or show it in the UI as needed. For now, we are throwing an exception with the error message
      throw Exception(errorMessage);
    }
  }
}
