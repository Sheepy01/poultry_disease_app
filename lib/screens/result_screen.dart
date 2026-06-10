import 'dart:io';

import 'package:flutter/material.dart';

import '../services/pdf_service.dart';
import '../utils/app_config.dart';
import '../utils/app_strings.dart';

class ResultScreen extends StatelessWidget {
  final File image;

  final Map<String, dynamic> result;

  final Map<String, dynamic> diseaseData;

  final PdfService pdfService = const PdfService();

  const ResultScreen({
    super.key,

    required this.image,

    required this.result,

    required this.diseaseData,
  });

  Color getConfidenceColor() {
    double score = double.tryParse(result['confidence'].toString()) ?? 0;

    if (score >= 85) {
      return Colors.green;
    }

    if (score >= 70) {
      return Colors.orange;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final disease = diseaseData[result['disease']] ?? {};
    final matchedFinding =
        disease['images']?[result['matched_image']]?['finding'];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    AppStrings.strings["detection_result"]!,

                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ClipRRect(
                borderRadius: BorderRadius.circular(30),

                child: Image.file(
                  image,

                  height: 250,

                  width: double.infinity,

                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,

                    end: Alignment.bottomRight,

                    colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      AppStrings.strings["detected_disease"]!,

                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      AppConfig.text(
                        disease['display_name'],
                        fallback: AppStrings.strings["unknown_disease"]!,
                      ),

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 30,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      AppStrings.strings["ai_analysis_complete"]!,

                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    const SizedBox(height: 25),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Column(),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      AppConfig.text(
                        disease['overview'],
                        fallback: AppStrings.strings["no_overview_available"]!,
                      ),

                      style: const TextStyle(
                        color: Colors.white,

                        height: 1.5,

                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _sectionTitle(AppStrings.strings["detected_finding"]!),

              const SizedBox(height: 15),

              _infoCard(
                icon: Icons.search,

                color: Colors.orange,

                child: Text(
                  AppConfig.text(
                    matchedFinding,
                    fallback: AppStrings.strings["no_finding_available"]!,
                  ),

                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),

              const SizedBox(height: 30),

              _sectionTitle(AppStrings.strings["clinical_symptoms"]!),

              const SizedBox(height: 15),

              Wrap(
                spacing: 10,

                runSpacing: 10,

                children: (disease['symptoms'] as List? ?? [])
                    .map<Widget>(
                      (symptom) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.08),

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          AppConfig.text(symptom),

                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 30),

              _sectionTitle(AppStrings.strings["immediate_actions"]!),

              const SizedBox(height: 15),

              ...(disease['immediate_actions'] as List? ?? []).map<Widget>(
                (action) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),

                  child: _infoCard(
                    icon: Icons.warning,

                    color: Colors.red,

                    child: Text(
                      AppConfig.text(action),

                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),

                  label: Text(AppStrings.strings["export_pdf_report"]!),

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppStrings.strings["generating_pdf_report"]!,
                        ),
                      ),
                    );

                    await pdfService.generateReport(
                      image: image,

                      disease: disease['display_name'] ?? const {},

                      confidence: result['confidence'].toString(),

                      symptoms: disease['symptoms'] ?? [],

                      actions: disease['immediate_actions'] ?? [],
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,

      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _infoCard({
    required Widget child,

    required IconData icon,

    required Color color,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),

            blurRadius: 10,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: color.withOpacity(0.1),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 15),

          Expanded(child: child),
        ],
      ),
    );
  }
}
