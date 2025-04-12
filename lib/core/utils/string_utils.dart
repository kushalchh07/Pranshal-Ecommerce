class StringUtils {
  static String toTitleCase(String text) {
    return text.split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  static String capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength) + '...';
  }
  /// Returns the initials of the first and last name from a full name string.

  String getFirstandLastNameInitals(String fullName) {
    if (fullName.isEmpty) {
      return 'N/A';
    }
    if (fullName.split(' ').length == 1) {
      return fullName[0];
    }
    List<String> name = fullName.split(' ');
    return name[0][0] + name[1][0];
  }
  static String convertMinutesToHoursMinutes(double minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  return '${h.toString().padLeft(2, '0')} hr ${m.toInt().toString().padLeft(2, '0')} min';
}

static String convertMinutesToHoursMinutesforquizes(int minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  return '${h.toString().padLeft(2, '0')} hr ${m.toInt().toString().padLeft(2, '0')} min';
}

}
