extension StringExtension on String {
  String get toCapitalized => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}

extension StringValidation on String {
  bool get isEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  bool get isPhoneNumber => RegExp(r"^\d{10}$").hasMatch(this);

  bool get isValidPassword => length >= 8 && RegExp(r"[A-Z]").hasMatch(this) && RegExp(r"[a-z]").hasMatch(this) && RegExp(r"\d").hasMatch(this);

  bool get isNotEmptyOrNull => isNotEmpty;
}

extension StringParsing on String {
  int? toInt() => int.tryParse(this);

  double? toDouble() => double.tryParse(this);

  DateTime? toDateTime() => DateTime.tryParse(this);
}

extension StringTransform on String {
  String capitalize() => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;

  String get asTitleCase => split(' ').map((word) => word.capitalize()).join(' ');

  String get removeWhiteSpaces => replaceAll(RegExp(r'\s+'), '');
}
