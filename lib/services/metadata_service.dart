import 'dart:convert';

import 'package:flutter/services.dart';

class MetadataService {
  Future<Map<String, dynamic>> loadDiseaseData() async {
    final jsonString = await rootBundle.loadString(
      'assets/metadata/disease_data.json',
    );

    return Map<String, dynamic>.from(json.decode(jsonString));
  }
}
