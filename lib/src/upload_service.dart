import 'dart:io';
import 'dart:typed_data';
import 'package:core_service/src/model/pic_size_model.dart';
import 'package:core_service/src/utils/logger.dart';
import 'package:dio/dio.dart';

class UploadService {
  Dio https;

  UploadService(this.https);

  Logger logger = Logger("UploadService");

  Future<PictureSizeModel> uploadPicture(File file, String type) async {
    final formData = FormData.fromMap({
      "fileUpload": await MultipartFile.fromFile(file.path),
      "uploadType": type
    });

    Response response = await https.post('/api/v1/dynamicFileupload',
        data: formData, onSendProgress: (value, result) {
      this.logger.debug("File size: $value, Uploaded: $result");
    });

    this.logger.debug("Upload File soccessfully");
    return PictureSizeModel.fromJson(response.data['data'][0]);
  }

  Future<PictureSizeModel> uploadPictureBytes(
      Uint8List bytes, String type) async {
    final formData = FormData.fromMap({
      "fileUpload": MultipartFile.fromBytes(bytes),
      "uploadType": type,
    });

    Response response = await https.post('/api/v1/dynamicFileupload',
        data: formData, onSendProgress: (value, result) {
      this.logger.debug("File size: $value, Uploaded: $result");
    });

    this.logger.debug("Upload File soccessfully");
    return PictureSizeModel.fromJson(response.data['data'][0]['imageSize']);
  }
}
