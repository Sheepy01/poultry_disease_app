class AppConfig {
  static String language = "hi";

  static String text(dynamic value, {String fallback = ""}) {
    if (value is Map) {
      final localized = value[language];
      if (localized is String && localized.isNotEmpty) {
        return localized;
      }

      final english = value["en"];
      if (english is String && english.isNotEmpty) {
        return english;
      }

      return fallback;
    }

    if (value is String && value.isNotEmpty) {
      return value;
    }

    return fallback;
  }
}
