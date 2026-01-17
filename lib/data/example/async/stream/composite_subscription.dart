import 'dart:async';

class CompositeSubscription {
  final _subscriptions = <StreamSubscription<Object>>{};
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  void add(StreamSubscription<Object> subscription) {
    if (_isDisposed) {
      throw StateError('CompositeSubscription is already disposed.');
    }
    _subscriptions.add(subscription);
  }

  Future<void> dispose() async {
    await Future.wait(
      _subscriptions.map((subscription) => subscription.cancel()),
    );
    _subscriptions.clear();
    _isDisposed = true;
  }
}
