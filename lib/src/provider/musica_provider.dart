import 'package:flutter/material.dart';

class MusicaProvider with ChangeNotifier {
  bool _isPlaying = false;
  AnimationController _controller;
  Duration _songDuration = new Duration(milliseconds: 0);
  Duration _current = new Duration(milliseconds: 0);

  String get totalMusica => this.printDuration(_songDuration);
  String get tiempoActual => this.printDuration(_current);
  
  double get porcentaje => (this._songDuration.inSeconds == 0)
      ? 0
      : this._current.inSeconds / this._songDuration.inSeconds;

  bool get isPlaying => this._isPlaying;
  AnimationController get controller => this._controller;

  set isPlaying(bool valor) {
    this._isPlaying = valor;
    notifyListeners();
  }

  set controller(AnimationController controller) {
    this._controller = controller;
  }

  Duration get songDuration => this._songDuration;
  Duration get current => this._current;

  set songDuration(Duration valor) {
    this._songDuration = valor;
    notifyListeners();
  }

  set current(Duration valor) {
    this._current = valor;
    notifyListeners();
  }

  String printDuration(Duration duracion) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duracion.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duracion.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
