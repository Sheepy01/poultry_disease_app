import 'dart:io';

import 'package:flutter/material.dart';

import '../services/pdf_service.dart';

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

                  const Text(
                    "Detection Result",

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
                    const Text(
                      "Detected Disease",

                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      disease['display_name'] ?? "Unknown Disease",

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 30,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "AI Analysis Complete",

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

                      child: Column(
                        // children: [

                        //   const Text(

                        //     "Confidence",

                        //     style: TextStyle(
                        //       color:
                        //       Colors.black54,
                        //     ),

                        //   ),

                        //   const SizedBox(
                        //     height: 5,
                        //   ),

                        //   Text(

                        //     "${result['confidence']}%",

                        //     style: TextStyle(

                        //       color:
                        //       getConfidenceColor(),

                        //       fontWeight:
                        //       FontWeight.bold,

                        //       fontSize: 24,

                        //     ),

                        //   ),

                        // ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      disease['overview'] ?? "No overview available.",

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

              _sectionTitle("Detected Finding"),

              const SizedBox(height: 15),

              _infoCard(
                icon: Icons.search,

                color: Colors.orange,

                child: Text(
                  disease['images']?[result['matched_image']]?['finding'] ??
                      "No finding available.",

                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),

              const SizedBox(height: 30),

              _sectionTitle("Clinical Symptoms"),

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
                          symptom.toString(),

                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 30),

              _sectionTitle("Immediate Actions"),

              const SizedBox(height: 15),

              ...(disease['immediate_actions'] as List? ?? []).map<Widget>(
                (action) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),

                  child: _infoCard(
                    icon: Icons.warning,

                    color: Colors.red,

                    child: Text(
                      action.toString(),

                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _sectionTitle("Mortality"),

              const SizedBox(height: 15),

              _infoCard(
                icon: Icons.monitor_heart,

                color: Colors.deepPurple,

                child: Text(
                  disease['mortality'] ?? "Unknown",

                  style: const TextStyle(
                    fontSize: 18,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),

                  label: const Text("Export PDF Report"),

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Generating PDF report...")),
                    );

                    await pdfService.generateReport(
                      image: image,

                      disease: disease['display_name'] ?? "Unknown Disease",

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
