import 'dart:async';
import 'dart:developer' as developer;

extension<T> on Stream<T> {
  // ignore: unused_element
  Stream<T> handle({
    void Function(T)? handleData,
    void Function(Object, StackTrace)? handleError,
    void Function()? handleDone,
  }) => transform<T>(
    StreamTransformer<T, T>.fromHandlers(
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
}

extension<T> on Stream<T> {
  // ignore: unused_element
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
