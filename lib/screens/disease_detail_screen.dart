import 'package:flutter/material.dart';

import '../models/disease_model.dart';

class DiseaseDetailScreen extends StatelessWidget {
  final DiseaseModel disease;

  const DiseaseDetailScreen({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    final firstImage = disease.images.keys.first;

    final imagePath = "assets/dataset/${disease.diseaseId}/$firstImage";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,

        title: Text(disease.displayName),
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
                    disease.displayName,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 28,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    disease.overview,

                    style: const TextStyle(color: Colors.white, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _sectionTitle("Symptoms"),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,

              runSpacing: 10,

              children: disease.symptoms
                  .map(
                    (symptom) => Chip(
                      label: Text(symptom.toString()),

                      backgroundColor: Colors.teal.shade50,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 30),

            _sectionTitle("Mortality"),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Text(disease.mortality),
              ),
            ),

            if (disease.treatment != null) ...[
              const SizedBox(height: 30),

              _sectionTitle("Treatment"),

              const SizedBox(height: 10),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),

                  child: Text(disease.treatment!),
                ),
              ),
            ],

            const SizedBox(height: 30),

            _sectionTitle("Immediate Actions"),

            const SizedBox(height: 10),

            ...disease.immediateActions.map(
              (action) => Card(
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),

                  title: Text(action.toString()),
                ),
              ),
            ),

            const SizedBox(height: 30),

            _sectionTitle("Reference Images"),

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
