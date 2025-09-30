extension IntExtensions on int {
  /// Format as currency (e.g., 1000 -> "1,000")
  String get formatted {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  /// Convert to ordinal (1st, 2nd, 3rd, etc.)
  String get ordinal {
    if (this >= 11 && this <= 13) return '${this}th';

    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;

  /// Clamp between min and max
  int clampValue(int min, int max) => clamp(min, max).toInt();

  /// Convert to duration in seconds
  Duration get seconds => Duration(seconds: this);

  /// Convert to duration in minutes
  Duration get minutes => Duration(minutes: this);

  /// Convert to duration in hours
  Duration get hours => Duration(hours: this);

  /// Convert to duration in days
  Duration get days => Duration(days: this);

  /// Format as time (e.g., 90 -> "1:30")
  String get asTime {
    final minutes = this ~/ 60;
    final seconds = this % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get percentage of total
  double percentOf(int total) {
    if (total == 0) return 0;
    return (this / total) * 100;
  }

  /// Format with sign (e.g., +5, -3)
  String get withSign => this >= 0 ? '+$this' : toString();

  /// Convert to roman numerals (up to 3999)
  String get toRoman {
    if (this < 1 || this > 3999) return toString();

    const values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    const numerals = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];

    var result = '';
    var num = this;

    for (var i = 0; i < values.length; i++) {
      while (num >= values[i]) {
        result += numerals[i];
        num -= values[i];
      }
    }

    return result;
  }
}
