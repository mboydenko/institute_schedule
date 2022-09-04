import 'dart:async';

class Debounce {
  Timer? _timer;

  void start(Duration duration, Function callback) {
    cancel();
    _timer = Timer(duration, () {
      callback();
    });
  }

  void cancel() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }
}
