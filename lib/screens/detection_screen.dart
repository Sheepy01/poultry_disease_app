import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/similarity_service.dart';
import '../services/tflite_service.dart';

class DetectionScreen extends StatefulWidget {

  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();

}

class _DetectionScreenState extends State<DetectionScreen> {

  File? selectedImage;

  String prediction = "";

  bool isLoading = false;

  final TFLiteService tfliteService = TFLiteService();

  final SimilarityService similarityService = SimilarityService();

  @override
  void initState() {

    super.initState();

    loadModel();

  }

  Future<void> loadModel() async {

    await tfliteService.loadModel();

  }

  Future<void> pickImage() async {

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {

      setState(() {

        selectedImage = File(pickedFile.path);

        prediction = "";

      });

      await detectDisease();

    }

  }

  Future<void> detectDisease() async {

    if (selectedImage == null) return;

    setState(() {
      isLoading = true;
    });

    try {

      List<double> embedding =
      await tfliteService.extractEmbedding(
        selectedImage!,
      );

      final result =
      await similarityService.findBestMatch(
        embedding,
      );

      setState(() {

        prediction =
        "${result['disease']}\nConfidence: ${result['confidence']}%";

      });

    } catch (e) {

      setState(() {

        prediction = "Error: $e";

      });

    }

    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Disease Detection"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Expanded(

              child: Container(

                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: selectedImage == null
                    ? const Center(
                  child: Text("No Image Selected"),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),

              ),

            ),

            const SizedBox(height: 20),

            if (isLoading)
              const CircularProgressIndicator(),

            if (prediction.isNotEmpty)

              Padding(

                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),

                child: Text(
                  prediction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: pickImage,

                child: const Text("Upload Chicken Image"),

              ),

            ),

          ],

        ),

      ),

    );

  }

}