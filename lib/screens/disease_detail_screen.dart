import 'package:flutter/material.dart';

import '../models/disease_model.dart';
import '../utils/app_config.dart';
import '../utils/app_strings.dart';

class DiseaseDetailScreen extends StatelessWidget {
  final DiseaseModel disease;

  final String selectedImage;

  const DiseaseDetailScreen({
    super.key,
    required this.disease,
    required this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = "assets/dataset/${disease.diseaseId}/$selectedImage";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,

        title: Text(AppConfig.text(disease.displayName)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),

              child: Image.asset(
                imagePath,

                height: 220,

                width: double.infinity,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),

                gradient: const LinearGradient(
                  colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    AppConfig.text(disease.displayName),

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 28,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    AppConfig.text(disease.overview),

                    style: const TextStyle(color: Colors.white, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _sectionTitle(AppStrings.strings["symptoms"]!),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,

              runSpacing: 10,

              children: disease.symptoms
                  .map(
                    (symptom) => Chip(
                      label: Text(AppConfig.text(symptom)),

                      backgroundColor: Colors.teal.shade50,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 30),

            if (AppConfig.text(disease.treatment).isNotEmpty) ...[
              const SizedBox(height: 30),

              _sectionTitle(AppStrings.strings["treatment"]!),

              const SizedBox(height: 10),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),

                  child: Text(AppConfig.text(disease.treatment)),
                ),
              ),
            ],

            const SizedBox(height: 30),

            _sectionTitle(AppStrings.strings["immediate_actions"]!),

            const SizedBox(height: 10),

            ...disease.immediateActions.map(
              (action) => Card(
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),

                  title: Text(AppConfig.text(action)),
                ),
              ),
            ),

            if (disease.differentialDiagnosis.isNotEmpty) ...[
              const SizedBox(height: 30),

              _sectionTitle(AppStrings.strings["differential_diagnosis"]!),

              const SizedBox(height: 10),

              ...disease.differentialDiagnosis.map(
                (diagnosis) => Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.medical_information,
                      color: Colors.teal,
                    ),
                    title: Text(AppConfig.text(diagnosis)),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 30),

            _sectionTitle(AppStrings.strings["reference_images"]!),

            const SizedBox(height: 15),

            GridView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              itemCount: disease.images.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                crossAxisSpacing: 10,

                mainAxisSpacing: 10,
              ),

              itemBuilder: (context, index) {
                final imageName = disease.images.keys.elementAt(index);

                final path = "assets/dataset/${disease.diseaseId}/$imageName";

                return ClipRRect(
                  borderRadius: BorderRadius.circular(18),

                  child: Image.asset(path, fit: BoxFit.cover),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,

      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
