import 'dart:math';

abstract class NumberLoopInterface {
  void cancel();

  bool isRunning();

  Stream<int> numberLoop();
}

class NumberLoop implements NumberLoopInterface {
  bool _isCancelled = true;

  @override
  void cancel() {
    _isCancelled = true;
  }

  @override
  bool isRunning() {
    return !_isCancelled;
  }

  @override
  Stream<int> numberLoop() async* {
    _isCancelled = false;
    var rnd = Random();
    while (!_isCancelled) {
      yield rnd.nextInt(10000);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  // 另一個寫法
  // @override
  // Stream<int> numberLoop() {
  //   _isCancelled = false;
  //   var rnd = Random();
  //   return Stream.periodic(
  //           const Duration(seconds: 1), (x) => rnd.nextInt(10000))
  //       .takeWhile((element) => !_isCancelled);
  // }
}
