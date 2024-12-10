import 'dart:io';
import 'package:image/image.dart';

class ImageUtils {
  static Future<File> compressImage(File imageFile) async {
    // Your compression logic here
    return imageFile; // Return the compressed image
  }

  static String getImageSize(File imageFile) {
    var image = decodeImage(imageFile.readAsBytesSync());
    return 'Width: ${image!.width}, Height: ${image.height}';
  }
}
