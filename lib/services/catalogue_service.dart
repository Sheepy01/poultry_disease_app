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
            diseaseId: disease.diseaseId,

            diseaseName: disease.displayName,

            imageName: imageName,

            finding: imageData["finding"] ?? "No finding available",
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
          treatment: value['treatment'],

          differentialDiagnosis: value['differential_diagnosis'],

          diseaseId: key,

          displayName: value['display_name'],

          overview: value['overview'],

          mortality: value['mortality'],

          symptoms: value['symptoms'],

          immediateActions: value['immediate_actions'],

          images: value['images'],
        ),
      );
    });

    return diseases;
  }
}
