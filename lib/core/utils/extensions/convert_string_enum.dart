extension EnumExtension<T extends Enum> on T {
  static T fromString<T extends Enum>(String type, List<T> values,
      {required T defaultValue}) {
    return values.firstWhere(
      (e) => e.toString().split('.').last == type,
      orElse: () => defaultValue,
    );
  }
}
