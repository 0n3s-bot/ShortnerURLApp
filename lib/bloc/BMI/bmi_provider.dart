import 'package:flutter/material.dart';

enum GenderType { male, female }

enum AgeMode { add, sub }

class BmiProvider extends ChangeNotifier {
  GenderType? _gender;

  double _weight = 0.0, _height = 0.0;
  int _age = 1;

  GenderType? get gender => _gender;
  double get weight => _weight;
  double get height => _height;
  int get age => _age;

  selectGender(GenderType gender) {
    _gender = gender;
    notifyListeners();
  }

  selectWeight(double weight) {
    _weight = weight;
    notifyListeners();
  }

  selectAge(AgeMode mode) {
    print(mode);
    switch (mode) {
      case AgeMode.add:
        _age++;
        notifyListeners();
        break;
      case AgeMode.sub:
        if (_age > 1) {
          _age--;
        }
        notifyListeners();
        break;
      default:
    }
  }

  selectHeight(double height) {
    _height = height;
    notifyListeners();
  }
}
