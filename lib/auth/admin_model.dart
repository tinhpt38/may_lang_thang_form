import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:may_lang_thang/model/show.dart';

class AdminModel extends ChangeNotifier {
  final databaseRef = FirebaseFirestore.instance;
  List<Show> _shows = List();
  List<Show> get shows => _shows;
  bool _err = false;
  String _errMsg = "";

  bool get err => _err;
  String get errMsg => _errMsg;
  bool _addSuccess = false;
  bool get addSuccess => _addSuccess;
  String _successMsg = "";
  String get successMsg => _successMsg;
  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;

  String _buildDate = DateTime.now().toString();
  String get buildDate => _buildDate;

  setBuildDate(String val) {
    _buildDate = val;
  }

  TextEditingController _singerController = TextEditingController();
  TextEditingController _vipController = TextEditingController();
  TextEditingController _midController = TextEditingController();
  TextEditingController _normalController = TextEditingController();

  TextEditingController get singerController => _singerController;
  TextEditingController get vipController => _vipController;
  TextEditingController get midController => _midController;
  TextEditingController get normalController => _normalController;

  Future<void> addShow(Show show) async {
    DocumentReference ref =
        await databaseRef.collection('show').add(show.toJson());
    if (ref != null) {
      _addSuccess = true;
      _successMsg = "Thêm show thành công";
    } else {
      _err = true;
      _errMsg = "Thêm không thành công";
    }
    getShow();
  }

  setSuccess(bool val) {
    _addSuccess = val;
    notifyListeners();
  }

  setError(bool val) {
    _err = false;
    notifyListeners();
  }

  Future<void> getShow() async {
    _shows.clear();
    await databaseRef.collection('show').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((d) {
        _shows.add(Show.fromJson(d.data()));
      });
    });
    notifyListeners();
  }

  Future<void> delete(Show show) async {
    String id = "";
    await databaseRef.collection('show').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((d) {
        // _shows.add(Show.fromJson(d.data()));
        if (show.singer == d.data()['singer'] &&
            show.buildDate == d.data()['buildDate']) {
          id = d.id;
        }
      });
    });
    await databaseRef.collection('show').doc(id).delete();
    await getShow();
  }

  void checkSave() async {
    _err = true;
    if (_singerController.text.isEmpty) {
      _errMsg = "Tên ca sĩ là bắt buộc";
    } else if (vipController.text.isEmpty) {
      _errMsg = "Vui lòng nhập giá khu ghế vip";
    } else if (midController.text.isEmpty) {
      _errMsg = "Vui lòng nhập giá khu phổ thông";
    } else if (normalController.text.isEmpty) {
      _errMsg = "Vui lòng nhập giá khu khán đài";
    } else {
      _err = false;
      Show show = Show(
          singer: _singerController.text.trim(),
          buildDate: _buildDate,
          vipRent: _vipController.text.trim(),
          midRent: _midController.text.trim(),
          normalRent: _normalController.text.trim());

      await addShow(show);
    }
    notifyListeners();
  }
}
