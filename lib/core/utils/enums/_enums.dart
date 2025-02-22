enum ThemeStyle { system, dark, light }

enum MethodType { get, post, put, delete, patch }

enum Menu { preview, share, getLink, remove, download }

// Query Operators
enum QueryOperator {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  whereIn,
  whereNotIn,
  isNull,
}

enum UserType {
  admin,
  user,
}

enum Gender {
  male,
  female,
}
