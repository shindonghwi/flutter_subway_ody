import 'package:flutter/material.dart';

class Throttler {
  final int milliseconds;

  int _lastActionTime;

  int get _millisecondsSinceEpoch => DateTime.now().millisecondsSinceEpoch;

  Throttler({required this.milliseconds})
      : _lastActionTime = DateTime.now().millisecondsSinceEpoch;

  void run(void Function() action, {Function(int)? callback}) {
    if (_millisecondsSinceEpoch - _lastActionTime > milliseconds) {
      action();
      _lastActionTime = _millisecondsSinceEpoch;
    }else{
      callback?.call((_millisecondsSinceEpoch - _lastActionTime) ~/ 1000);
    }
  }
}