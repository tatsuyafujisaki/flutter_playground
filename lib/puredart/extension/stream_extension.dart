import 'dart:async';

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
        print('👀handleData: $data');
        sink.add(data);
      },
      handleError: (error, stackTrace, sink) {
        print('👀handleError: $error\n$stackTrace');
        sink.addError(error, stackTrace);
      },
      handleDone: (sink) {
        print('👀handleDone');
        sink.close();
      },
    ),
  );
}
