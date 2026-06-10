class DiseaseModel {
  final String diseaseId;

  final Map<String, dynamic> displayName;

  final Map<String, dynamic> overview;

  final Map<String, dynamic> mortality;

  final List<dynamic> symptoms;

  final List<dynamic> immediateActions;

  final Map<String, dynamic> images;

  final Map<String, dynamic> treatment;

  final List<dynamic> differentialDiagnosis;

  DiseaseModel({
    required this.diseaseId,

    required this.displayName,

    required this.overview,

    required this.mortality,

    required this.symptoms,

    required this.immediateActions,

    required this.images,

    required this.treatment,

    required this.differentialDiagnosis,
  });
}
