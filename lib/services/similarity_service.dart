import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class SimilarityService {

  Future<List<dynamic>> loadEmbeddings() async {

    String jsonString = await rootBundle.loadString(
      'assets/embeddings/embeddings.json',
    );

    return json.decode(jsonString);

  }

  double cosineSimilarity(
      List<double> a,
      List<double> b,
      ) {

    double dotProduct = 0;

    double normA = 0;

    double normB = 0;

    for (int i = 0; i < a.length; i++) {

      dotProduct += a[i] * b[i];

      normA += a[i] * a[i];

      normB += b[i] * b[i];

    }

    return dotProduct / (
        sqrt(normA) * sqrt(normB)
    );

  }

  Future<Map<String, dynamic>> findBestMatch(
      List<double> uploadedEmbedding,
      ) async {

    List<dynamic> embeddings = await loadEmbeddings();

    double bestScore = -1;

    String bestDisease = "Unknown";

    String matchedImage = "";

    for (var item in embeddings) {

      List<dynamic> embeddingDynamic = item['embedding'];

      List<double> storedEmbedding = embeddingDynamic
          .map((e) => (e as num).toDouble())
          .toList();

      double score = cosineSimilarity(
        uploadedEmbedding,
        storedEmbedding,
      );

      if (score > bestScore) {

        bestScore = score;

        bestDisease = item['disease'];

        matchedImage = item['image'];

      }

    }

    return {

      'disease': bestDisease,

      'confidence': (bestScore * 100)
          .toStringAsFixed(2),

      'matched_image': matchedImage,

    };

  }

}