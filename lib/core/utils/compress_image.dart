import 'dart:typed_data';

import 'package:image/image.dart' as img;

Future<List<int>> compressImage(Uint8List bytes) async {
  int imageLength = bytes.length;
  if (imageLength < 1000000) return bytes;

  final img.Image image = img.decodeImage(bytes)!;

  int compressQuality = 100;
  int length = imageLength;
  List<int> newByte = [];

  do {
    compressQuality -= -10;

    newByte = img.encodeJpg(image, quality: compressQuality);

    length = newByte.length;
  } while (length > 1000000);

  return newByte;
}
