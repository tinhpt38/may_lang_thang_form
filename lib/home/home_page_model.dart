import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:may_lang_thang/home/email_template.dart';
import 'package:may_lang_thang/model/show.dart';

class HomeModel extends ChangeNotifier {
  List<Step> _steps = [
    Step.landing,
    Step.name,
    Step.phone,
    Step.show,
    Step.rent,
    Step.indexi,
    Step.submit
  ];
  Step _currentStep = Step.landing;

  List<Step> get steps => _steps;
  bool _isStepLogin = false;
  bool _loginSuccess = false;
  bool get isStepLogin => _isStepLogin;
  bool get loginSuccess => _loginSuccess;

  Step get currentStep => _currentStep;
  int _stepIndex = 0;
  int get stepIndex => _stepIndex;

  String _dropValue = "";
  String get dropValue => _dropValue;
  List<String> _dropItems = List();
  List<String> get dropItems => _dropItems;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _indexController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _showControler = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get indexController => _indexController;
  TextEditingController get userController => _userController;
  TextEditingController get pwdController => _pwdController;
  TextEditingController get showControler => _showControler;

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

  String _user = "admin";
  String _password = "@cps@admin@1211045";

  List<Show> _shows = List();
  List<Show> get shows => _shows;

  final databaseRef = FirebaseFirestore.instance;

  String _buildDate = DateTime.now().toString();
  String get buildDate => _buildDate;

  setBuildDate(String val) {
    _buildDate = val;
    notifyListeners();
  }

  Future<void> getShow() async {
    _shows.clear();
    await databaseRef.collection('show').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((d) {
        DateTime today = DateTime.now();
        Show show = Show.fromJson(d.data());
        DateTime buildDate = DateTime.parse(show.buildDate);
        if (buildDate.day >= today.day &&
            buildDate.month >= today.month &&
            buildDate.year >= today.year) {
          _shows.add(show);
        }
      });
    });
    notifyListeners();
  }

  login() {
    if (_userController.text == _user && _pwdController.text == _password) {
      _loginSuccess = true;
      _error = false;
      _errMessage = "";
      _isStepLogin = false;
    } else {
      _loginSuccess = false;
      _errMessage = "Thông tin tài khoản đăng nhập sai!";
      _error = true;
    }
    notifyListeners();
  }

  setLoginSuccess(bool val) {
    _loginSuccess = val;
    notifyListeners();
  }

  setIsStepLogin(bool val) {
    _isStepLogin = val;
    notifyListeners();
  }

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
      case Step.show:
        {
          _error = true;
          if (_showControler.text.isEmpty) {
            _errMessage = "Nhập tên ca sĩ";
          } else {
            _selectShow = findShow();
            if (_selectShow == null) {
              _error = true;
              _errMessage =
                  "Không có buổi biểu diễn nào, chọn lại ngày hoặc tên ca sĩ";
            }
          }

          break;
        }
      default:
    }
    // _error = false;
  }

  Show findShow() {
    DateTime dateIn = DateTime.parse(_buildDate);
    for (int i = 0; i < _shows.length; i++) {
      Show e = _shows[i];
      DateTime dateFromShow = DateTime.parse(e.buildDate);
      if (e.singer.toLowerCase() == _showControler.text.trim().toLowerCase() &&
          (dateIn.day == dateFromShow.day &&
              dateIn.month == dateFromShow.month &&
              dateIn.year == dateFromShow.year)) {
        _error = false;
        return e;
      }
    }
    return null;
  }

  Show _selectShow;
  Show get selectShow => _selectShow;

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
        rent = "Khu VIP - ${selectShow.vipRent} VNĐ";
        break;
      case IndexValue.mid:
        rent = "Khu Lang Thang - ${selectShow.midRent} VNĐ";
        break;

      case IndexValue.low:
        rent = "Khu khán đài - ${selectShow.normalRent} VNĐ";
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
    DateTime a = DateTime.parse(selectShow.buildDate);
    String singerDate = "";
    singerDate = a.day.toString() +
        "/" +
        a.month.toString() +
        "/" +
        a.year.toString() +
        js.context.callMethod('alertMessage', [
          emailTemplate(
            name: _nameController.text,
            phone: _phoneController.text,
            rent: rent,
            indexOnboard: indexOnBoard,
            now: creatAt,
            singer: selectShow.singer,
            buildate: singerDate,
          ),
          () {
            setSending(false);
            setMailSuccess(true);
          }
        ]);
  }
}

enum Step { landing, name, phone, show, rent, indexi, submit }

enum IndexValue { vip, mid, low, option }
