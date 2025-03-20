import '/core/_core.dart';

extension ResultExtensions<T> on Result<T> {
  void handle({
    required Function(T data) onSuccess,
    required Function(String error) onError,
  }) {
    if (this is Success<T>) {
      onSuccess((this as Success<T>).data);
    } else if (this is Failure<T>) {
      onError((this as Failure<T>).error);
    }
  }

  Future<void> handleAsync({
    required Function(T data) onSuccess,
    required Function(String error) onError,
  }) async {
    if (this is Success<T>) {
      await onSuccess((this as Success<T>).data);
    } else if (this is Failure<T>) {
      await onError((this as Failure<T>).error);
    }
  }
}
