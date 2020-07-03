import 'package:flutter_ninja/timerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  int work = 1;
  int shortBreak = 5;
  int longBreak = 15;
  double remainingPotion = 1; //ranges from 1 - 0;
  bool _isActive = false;
  Duration _remainingTime;
  Duration _fullTime;

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime');
    shortBreak =
        prefs.getInt('shortBreak') == null ? 30 : prefs.getInt('shortBreak');
    longBreak =
        prefs.getInt('longBreak') == null ? 30 : prefs.getInt('longBreak');
  }

  void startWork() async {
    await readSettings();
    _remainingTime = Duration(minutes: this.work, seconds: 0);
    _fullTime = _remainingTime;
    remainingPotion = 1;
  }

  void startBreak(bool isShort) {
    remainingPotion = 1;
    if (isShort) {
      _remainingTime = Duration(minutes: this.shortBreak, seconds: 0);
      _fullTime = _remainingTime;
    } else {
      _remainingTime = Duration(minutes: this.longBreak, seconds: 0);
      _fullTime = _remainingTime;
    }
  }

  // Starts the Timer
  void startTimer() {
    if (this._remainingTime.inSeconds > 0) {
      this._isActive = true;
    }
  }

  // Stop the Timer
  void stopTimer() {
    this._isActive = false;
  }

  String _formatTime(Duration t) {
    String minutes = t.inMinutes < 10
        ? '0${t.inMinutes.toString()}'
        : t.inMinutes.toString();
    int remainingSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds = remainingSeconds < 10
        ? '0${remainingSeconds.toString()}'
        : remainingSeconds.toString();

    return '$minutes:$seconds';
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      if (_isActive) {
        _remainingTime = _remainingTime - Duration(seconds: 1);
        remainingPotion = _remainingTime.inSeconds / _fullTime.inSeconds;

        if (_remainingTime.inSeconds <= 0) {
          _isActive = false;
        }
      }
      return TimerModel(remainingPotion, _formatTime(_remainingTime));
    });
  }
}
