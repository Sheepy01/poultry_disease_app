import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/disease_model.dart';
import '../models/catalogue_item.dart';

class CatalogueService {
  Future<List<CatalogueItem>> loadCatalogueItems() async {
    final diseases = await loadDiseases();

    List<CatalogueItem> items = [];

    for (final disease in diseases) {
      disease.images.forEach((imageName, imageData) {
        items.add(
          CatalogueItem(
            disease: disease,
            imageName: imageName,
            finding: Map<String, dynamic>.from(
              imageData["finding"] ?? const {},
            ),
          ),
        );
      });
    }

    return items;
  }

  Future<List<DiseaseModel>> loadDiseases() async {
    final jsonString = await rootBundle.loadString(
      'assets/metadata/disease_data.json',
    );

    final data = json.decode(jsonString);

    List<DiseaseModel> diseases = [];

    data.forEach((key, value) {
      diseases.add(
        DiseaseModel(
          treatment: Map<String, dynamic>.from(value['treatment'] ?? const {}),

          differentialDiagnosis: List<dynamic>.from(
            value['differential_diagnosis'] ?? const [],
          ),

          diseaseId: key,

          displayName: Map<String, dynamic>.from(
            value['display_name'] ?? const {},
          ),

          overview: Map<String, dynamic>.from(value['overview'] ?? const {}),

          mortality: Map<String, dynamic>.from(value['mortality'] ?? const {}),

          symptoms: List<dynamic>.from(value['symptoms'] ?? const []),

          immediateActions: List<dynamic>.from(
            value['immediate_actions'] ?? const [],
          ),

          images: Map<String, dynamic>.from(value['images'] ?? const {}),
        ),
      );
    });

    return diseases;
  }
}
