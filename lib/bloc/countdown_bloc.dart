import 'dart:async';

class CountdownTime {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  CountdownTime(this.hours, this.minutes, this.seconds);

  int getTotalTimeInSeconds() {
    int totalMinutes = (hours * 60) + minutes;
    int totalSeconds = (totalMinutes * 60) + seconds;
    return totalSeconds;
  }

  void setCountdown(int totalSeconds) {
    hours = 0;
    minutes = 0;
    seconds = totalSeconds;
    if (seconds < 60) return;
    while (seconds - 60 >= 0) {
      minutes++;
      seconds -= 60;
    }

    if (minutes < 60) return;
    while (minutes - 60 >= 0) {
      hours++;
      minutes -= 60;
    }
  }

  // void printTime() {
  //   print("Hours : $hours");
  //   print("Minutes : $minutes");
  //   print("Seconds : $seconds");
  // }
}

class CountdownBloc {
  CountdownBloc() {
    _countdownController.sink.add(CountdownTime(0, 0, 0));
  }
  Timer? timer;

  final _countdownController = StreamController<CountdownTime>();
  Stream<CountdownTime> get countdownStream => _countdownController.stream;

  void startCountdown(CountdownTime time) {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        time.setCountdown(time.getTotalTimeInSeconds()-1);
        _countdownController.sink.add(time);
      },
    );
  }
}
