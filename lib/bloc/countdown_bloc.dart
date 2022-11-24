import 'dart:async';

import 'package:assignment2/bloc/input_status_bloc.dart';

class CountdownTime {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  CountdownTime(this._hours, this._minutes, this._seconds);

  String getHoursText() {
    if (_hours < 10) {
      return (_hours == 0) ? "00" : "0$_hours";
    }
    return _hours.toString();
  }

  String getMinutesText() {
    if (_minutes < 10) {
      return (_minutes == 0) ? "00" : "0$_minutes";
    }
    return _minutes.toString();
  }

  String getSecondsText() {
    if (_seconds < 10) {
      return (_seconds == 0) ? "00" : "0$_seconds";
    }
    return _seconds.toString();
  }

  int getTotalTimeInSeconds() {
    int totalMinutes = (_hours * 60) + _minutes;
    int totalSeconds = (totalMinutes * 60) + _seconds;
    return totalSeconds;
  }

  void setCountdown(int totalSeconds) {
    _hours = 0;
    _minutes = 0;
    _seconds = totalSeconds;
    if (_seconds < 60) return;
    while (_seconds - 60 >= 0) {
      _minutes++;
      _seconds -= 60;
    }

    if (_minutes < 60) return;
    while (_minutes - 60 >= 0) {
      _hours++;
      _minutes -= 60;
    }
  }

  // void printTime() {
  //   print("Hours : $_hours");
  //   print("Minutes : $_minutes");
  //   print("Seconds : $_seconds");
  // }
}

class CountdownBloc {
  Timer? timer;

  CountdownBloc() {
    _countdownController.sink.add(CountdownTime(0, 0, 0));
  }

  final _countdownController = StreamController<CountdownTime>();
  Stream<CountdownTime> get countdownStream => _countdownController.stream;

  void startCountdown(CountdownTime time, InputStatusBloc inputStatusBloc) {
    // time.setCountdown(time.getTotalTimeInSeconds() + 1);
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (time.getTotalTimeInSeconds() - 1 <= 0) {
          timer?.cancel();
          inputStatusBloc.changeInputStatus();
        }
        time.setCountdown(time.getTotalTimeInSeconds() - 1);
        _countdownController.sink.add(time);
      },
    );
  }
}
