import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectionScreen extends StatefulWidget {

  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();

}

class _DetectionScreenState extends State<DetectionScreen> {

  File? selectedImage;

  Future<void> pickImage() async {

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {

      setState(() {
        selectedImage = File(pickedFile.path);
      });

    }

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