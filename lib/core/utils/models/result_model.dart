// Result Type
sealed class Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String error) = Failure<T>;
}

class Success<T> implements Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> implements Result<T> {
  final String error;
  const Failure(this.error);
}
