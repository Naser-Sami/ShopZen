// Future Timeout Handling:
import 'dart:developer';

extension FutureExtensions<T> on Future<T> {
  Future<T> withTimeout(Duration duration, {T? onTimeout}) => timeout(duration, onTimeout: () => onTimeout as T);
}

// Stream Utilities:
extension StreamExtensions<T> on Stream<T> {
  Stream<T> logEvents() => map((event) {
        log('Stream event: $event');
        return event;
      });

  Stream<List<T>> toListStream() => asyncMap((event) async => [event]);
}
