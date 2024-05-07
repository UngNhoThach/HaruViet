extension StringExtension on String {
  String get capitalizeFirst =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}
