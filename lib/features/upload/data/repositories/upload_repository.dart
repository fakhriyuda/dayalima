import 'dart:io';

import 'package:dayagram/core/client/client.dart';
import 'package:dayagram/core/client/result.dart';
import 'package:dayagram/features/upload/data/model/upload.dart';
import 'package:dio/dio.dart';

class UploadRepository {
  static Future uploadCoverPodcast(
      {required message, String? videoUrl, File? image}) async {
    FormData formData = FormData.fromMap({
      'message': message,
      'videoUrl': videoUrl,
    });

    if (image != null) {
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(image.path, filename: image.path),
        ),
      );
    }
    try {
      Response<String> response = await Client().dio.post(
            'https://dlabstech-test.irufano.com/api/post',
            data: formData,
          );
      return Result(ResultType.Success, "Berhasil Post",
          data: uploadFromJson(response.data!));
    } on DioError catch (_) {
      rethrow;
    }
  }
}
