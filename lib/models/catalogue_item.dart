import 'disease_model.dart';

class CatalogueItem {
  final DiseaseModel disease;

  final String imageName;

  final String finding;

  CatalogueItem({
    required this.disease,

    required this.imageName,

    required this.finding,
  });
}
