import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  late Interpreter interpreter;

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset(
      'assets/models/mobilenet_v2.tflite',
    );

    print("TFLite model loaded");
  }

  Future<List<double>> extractEmbedding(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();

    img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      throw Exception("Unable to decode image");
    }

    img.Image resizedImage = img.copyResize(
      originalImage,
      width: 224,
      height: 224,
    );

    var input = List.generate(
      1,
      (_) => List.generate(
        224,
        (_) => List.generate(224, (_) => List.filled(3, 0.0)),
      ),
    );

    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resizedImage.getPixel(x, y);

        input[0][y][x][0] = (pixel.r - 127.5) / 127.5;
        input[0][y][x][1] = (pixel.g - 127.5) / 127.5;
        input[0][y][x][2] = (pixel.b - 127.5) / 127.5;
      }
    }

    var output = List.generate(1, (_) => List.filled(1280, 0.0));

    interpreter.run(input, output);

    return List<double>.from(output[0]);
  }
}
