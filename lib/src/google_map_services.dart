import 'dart:typed_data';

import 'package:core_service/core_service.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:io' show Platform;

class GoogleMapServices {
  static final _logger = Logger("GoogleMapServices");

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    _logger.debug("Start GetBytesFromAsset...");
    _logger.debug("Path $path");
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    _logger.debug("Finished GetBytesFromAsset...");
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  /// Get uint8List for ios
  ///final Uint8List markerIcon = await getBytesFromAsset('assets/images/flutter.png', 100);
  // final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
  static Future<Uint8List> getBytesFromAssetAutoSize(String path) {
    _logger.debug("Start GetBytesFromAssetAutoSize...");
    final size = Platform.isIOS ? 76 : 124;
    return getBytesFromAsset(path, size);
  }
}
