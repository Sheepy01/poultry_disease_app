import 'dart:convert';

import 'package:flutter/services.dart';

class MetadataService {

  Future<Map<String, dynamic>> loadDiseaseData() async {

    String jsonString = await rootBundle.loadString(
      'assets/metadata/disease_data.json',
    );

    return json.decode(jsonString);

  }

}