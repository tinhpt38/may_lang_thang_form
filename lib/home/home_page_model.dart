import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  List<Step> _steps = [
    Step.landing,
    Step.name,
    Step.phone,
    Step.rent,
    Step.indexi,
    Step.submit
  ];

  List<Step> get steps => _steps;

  Step _currentStep = Step.landing;
  Step get currentStep => _currentStep;
  int _stepIndex = 0;
  int get stepIndex => _stepIndex;

  void nextStep() {
    _stepIndex++;
    _currentStep = _steps[_stepIndex];
    notifyListeners();
  }

  void backStep() {
    if (_stepIndex > 0) {
      _stepIndex--;
    }
    _currentStep = _steps[_stepIndex];
    notifyListeners();
  }
}

enum Step { landing, name, phone, rent, indexi, submit }
