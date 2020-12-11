import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:may_lang_thang/home/email_template.dart';

class HomeModel extends ChangeNotifier {
  List<Step> _steps = [
    Step.landing,
    Step.name,
    Step.phone,
    Step.rent,
    Step.indexi,
    Step.submit
  ];
  Step _currentStep = Step.landing;

  List<Step> get steps => _steps;

  // Step _currentStep = Step.landing;
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

  bool _isSending = false;
  bool get isSending => _isSending;

  bool _mailSuccess = false;
  bool get mailSuccess => _mailSuccess;

  setSending(bool value) {
    _isSending = value;
    notifyListeners();
  }

  setMailSuccess(bool value) {
    _mailSuccess = value;
    notifyListeners();
  }

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
    // _error = false;
  }

  void nextStep() async {
    checkError();
    if (!_error) {
      _stepIndex++;
      _currentStep = _steps[_stepIndex];
    }
    // await sendEmail();
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

  Future<void> mailto() async {
    setSending(true);
    setMailSuccess(false);
    String rent = "";
    String indexOnBoard =
        indexController.text.isEmpty ? "Chưa chọn ghế" : indexController.text;
    switch (indexValue) {
      case IndexValue.vip:
        rent = "Khu VIP - 850.000 VNĐ";
        break;
      case IndexValue.mid:
        rent = "Khu Lang Thang - 650.000 VNĐ";
        break;

      case IndexValue.low:
        rent = "Khu khán đài - 400.000 VNĐ";
        break;
      case IndexValue.option:
        rent = "Chọn sau khi liên hệ";
        break;
      default:
    }

    DateTime now = DateTime.now();
    String creatAt = now.day.toString() +
        "/" +
        now.month.toString() +
        "/" +
        now.year.toString() +
        " - " +
        now.hour.toString() +
        ":" +
        now.minute.toString();

    // html.querySelector('#customerName').text = _nameController.text;
    // html.querySelector('#customerPhone').text = _phoneController.text;
    // html.querySelector("#rent").text = rent;
    // html.querySelector('#indexOnBoard').text = indexOnBoard;
    // html.querySelector("#creatAt").text = "";

    js.context.callMethod('alertMessage', [
      emailTemplate(_nameController.text, _phoneController.text, rent,
          indexOnBoard, creatAt),
      () {
        setSending(false);
        setMailSuccess(true);
      }
    ]);
  }
}

enum Step { landing, name, phone, rent, indexi, submit }

enum IndexValue { vip, mid, low, option }
