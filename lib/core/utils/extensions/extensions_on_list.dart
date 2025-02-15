extension ListUtils<T> on List<T> {
  List<T> get reversedList => reversed.toList();

  List<T> sorted([int Function(T a, T b)? compare]) => (this..sort(compare));

  T? get firstOrNull => isNotEmpty ? first : null;

  T? get lastOrNull => isNotEmpty ? last : null;
}

extension NullableList<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
