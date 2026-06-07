class DiseaseModel {
  final String diseaseId;

  final String displayName;

  final String overview;

  final String mortality;

  final List<dynamic> symptoms;

  final List<dynamic> immediateActions;

  final Map<String, dynamic> images;

  final String? treatment;

  final List<dynamic>? differentialDiagnosis;

  DiseaseModel({
    required this.diseaseId,

    required this.displayName,

    required this.overview,

    required this.mortality,

    required this.symptoms,

    required this.immediateActions,

    required this.images,

    this.treatment,

    this.differentialDiagnosis,
  });
}
