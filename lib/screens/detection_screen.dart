import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/similarity_service.dart';
import '../services/tflite_service.dart';
import '../utils/app_strings.dart';
import 'result_screen.dart';

import '../services/metadata_service.dart';

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
  final MetadataService metadataService = MetadataService();

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

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

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
    await Future.delayed(const Duration(milliseconds: 2000));

    try {
      List<double> embedding = await tfliteService.extractEmbedding(
        selectedImage!,
      );

      final result = await similarityService.findBestMatch(embedding);

      final diseaseData = await metadataService.loadDiseaseData();

      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (_) => ResultScreen(
            image: selectedImage!,

            result: result,

            diseaseData: diseaseData,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        prediction = AppStrings.strings["unable_to_analyze_image"]!;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.strings["detect_disease"]!)),

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
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.document_scanner,
                              size: 80,
                              color: Colors.teal.shade300,
                            ),

                            const SizedBox(height: 20),

                            Text(
                              AppStrings.strings["upload_poultry_image"]!,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              AppStrings.strings["ai_analyze_patterns"]!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.file(selectedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              Container(
                margin: const EdgeInsets.only(bottom: 20),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,

                      child: Stack(
                        alignment: Alignment.center,

                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 6,

                            color: Colors.teal.shade400,
                          ),

                          Icon(
                            Icons.document_scanner,
                            color: Colors.teal.shade400,
                            size: 35,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      AppStrings.strings["ai_scanning_in_progress"]!,

                      style: TextStyle(
                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      AppStrings.strings["analyzing_poultry_patterns"]!,

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

            if (prediction.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),

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

                child: Text(AppStrings.strings["upload_chicken_image"]!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
