import 'dart:async';
import 'dart:developer' as developer;

extension StreamExtension<T> on Stream<T> {
  Stream<T> handle({
    void Function(T)? handleData,
    void Function(Object, StackTrace)? handleError,
    void Function()? handleDone,
  }) => transform<T>(
    .fromHandlers(
      handleData: (data, sink) {
        handleData?.call(data);
        sink.add(data);
      },
      handleError: (error, stackTrace, sink) {
        handleError?.call(error, stackTrace);
        sink.addError(error, stackTrace);
      },
      handleDone: (sink) {
        handleDone?.call();
        sink.close();
      },
    ),
  );

  Stream<T> log() => transform<T>(
    StreamTransformer<T, T>.fromHandlers(
      handleData: (data, sink) {
        developer.log('👀handleData: $data');
        sink.add(data);
      },
      handleError: (error, stackTrace, sink) {
        developer.log('👀handleError: $error\n$stackTrace');
        sink.addError(error, stackTrace);
      },
      handleDone: (sink) {
        developer.log('👀handleDone');
        sink.close();
      },
    ),
  );
}
