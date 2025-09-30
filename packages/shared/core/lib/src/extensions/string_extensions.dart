extension StringExtensions on String {
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is empty or whitespace only
  bool get isBlank => trim().isEmpty;

  /// Check if string is not empty and not whitespace only
  bool get isNotBlank => !isBlank;

  /// Truncate string to specified length with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Convert to snake_case
  String get toSnakeCase {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }

  /// Convert to camelCase
  String get toCamelCase {
    final words = split(RegExp(r'[_\s]+'));
    if (words.isEmpty) return this;

    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize).join();
  }

  /// Count words in string
  int get wordCount => split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;

  /// Check if contains only numbers
  bool get isNumeric => double.tryParse(this) != null;

  /// Parse to int safely
  int? get toIntOrNull => int.tryParse(this);

  /// Parse to double safely
  double? get toDoubleOrNull => double.tryParse(this);

  /// Reverse string
  String get reverse => split('').reversed.join();

  /// Check if palindrome
  bool get isPalindrome {
    final cleaned = toLowerCase().removeWhitespace;
    return cleaned == cleaned.reverse;
  }
}

extension NullableStringExtensions on String? {
  /// Check if null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if null or blank (whitespace only)
  bool get isNullOrBlank => this == null || this!.isBlank;

  /// Get value or default
  String orDefault(String defaultValue) => this ?? defaultValue;
}
