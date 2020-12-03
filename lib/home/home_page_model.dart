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

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _indexController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get indexController => _indexController;

  bool _error = false;
  String _errMessage = "";

  bool get error => _error;
  String get errMessage => _errMessage;

  IndexValue _indexValue = IndexValue.vip;
  IndexValue get indexValue => _indexValue;

  setError(bool val) {
    _error = val;
    notifyListeners();
  }

  void checkError() {
    switch (currentStep) {
      case Step.name:
        {
          if (_nameController.text.trim().isEmpty) {
            _error = true;
            _errMessage = "Vui lòng nhập họ tên";
          }
          break;
        }
      case Step.phone:
        {
          _error = true;
          if (_phoneController.text.trim().isEmpty) {
            _errMessage = "Vui lòng nhập số điện thoại";
          } else if (!validPhone(_phoneController.text)) {
            _errMessage = "Số điện thoại không hợp lệ";
          } else {
            _error = false;
          }
          break;
        }
      default:
    }
    _error = false;
  }

  void nextStep() {
    checkError();
    if (!_error) {
      _stepIndex++;
      _currentStep = _steps[_stepIndex];
    }
    notifyListeners();
  }

  void backStep() {
    _error = false;
    if (_stepIndex > 0) {
      _stepIndex--;
    }
    _currentStep = _steps[_stepIndex];
    notifyListeners();
  }

  bool validPhone(String phone) {
    RegExp phoneReg = RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$");
    return phoneReg.hasMatch(phone);
  }

  void onIndexValueChange(IndexValue value) {
    _indexValue = value;
    notifyListeners();
  }
}

enum Step { landing, name, phone, rent, indexi, submit }

enum IndexValue { vip, mid, low, option }
