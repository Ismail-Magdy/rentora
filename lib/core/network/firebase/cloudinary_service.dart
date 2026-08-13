import 'dart:io';
import 'package:dio/dio.dart' as dio;

class CloudinaryService {
  final dio.Dio _dio = dio.Dio();

  // It is highly recommended to use environment variables (.env) for security
  final String cloudName = "xcjs2n7s";
  final String uploadPreset = "rentora";

  /// Function to upload an image to Cloudinary and return the secure URL
  /// Throws an Exception with a user-friendly message on failure
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
