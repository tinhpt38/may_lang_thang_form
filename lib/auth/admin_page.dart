import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:matt_q/matt_q.dart';
import 'package:may_lang_thang/auth/admin_model.dart';
import 'package:may_lang_thang/auth/show_item.dart';
import 'package:may_lang_thang/components/button.dart';
import 'package:may_lang_thang/components/input.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends MattQ<AdminPage, AdminModel> {
  AdminModel _model;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _model.getShow();
    });
  }

  @override
  Function(BuildContext context, AdminModel model, Widget child) builder() {
    return (context, model, child) {
      _model = model;
      Future.delayed(Duration.zero, () {
        if (model.err) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: model.errMsg,
            ),
          );
          model.setError(false);
        }
        if (model.addSuccess) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: model.successMsg,
            ),
          );
          model.setSuccess(false);
        }
      });
      return ResponsiveBuilder(builder: (context, sizeInfo) {
        if (sizeInfo.deviceScreenType == DeviceScreenType.desktop) {
          return buildDesktop(context, model);
        } else if (sizeInfo.deviceScreenType == DeviceScreenType.tablet) {
          return buildTablet(context, model);
        } else if (sizeInfo.deviceScreenType == DeviceScreenType.mobile) {
          return buildMobile(context, model);
        }
        return Center(
          child: Text("UI's support for this size!"),
        );
      });
    };
  }

  Widget buildDesktop(BuildContext context, AdminModel model) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildCreateShow(model, size),
            ),
            VerticalDivider(width: 2, color: Colors.grey),
            Expanded(
              flex: 1,
              child: buildListShow(model, size),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTablet(BuildContext context, AdminModel model) {
    return buildDesktop(context, model);
  }

  Widget buildMobile(BuildContext context, AdminModel model) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 32),
        child: buildCreateShow(model, size),
      ),
    );
  }

  Widget buildCreateShow(AdminModel model, Size size) {
    return Container(
      // width: model.isWebSize? size.width * (1 / 2): size.width,
      alignment: Alignment.topCenter,
      child: ListView(
        children: [
          SizedBox(
            height: 42,
          ),
          Text(
            "TẠO SHOW DIỄN",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 42,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "TẠO TÊN CA SĨ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Input(
              title: "TÊN CA SĨ",
              controller: _model.singerController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "NHẬP NGÀY DIỄN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DateTimePicker(
              dateMask: 'dd MM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'CHỌN NGÀY DIỄN',
              onChanged: (val) {
                model.setBuildDate(val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "NHẬP GIÁ KHU VIP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Input(
              title: "GIÁ KHU VIP",
              controller: model.vipController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "NHẬP GIÁ KHU PHỔ THÔNG",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Input(
              title: "GIÁ KHU PHỔ THÔNG",
              controller: model.midController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "NHẬP GIÁ KHU KHÁN ĐÀI",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Input(
              title: "KHU KHÁN ĐÀI",
              controller: model.normalController,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 1 / 4),
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Button(
              label: "Lưu",
              onPress: model.checkSave,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListShow(AdminModel model, Size ize) {
    if (model.shows.isEmpty) {
      return Container(
        child: Text('Chưa có dữ liệu để hiển thị'),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 42,
          ),
          Text(
            "DANH SÁCH SHOW DIỄN",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 42,
          ),
          Expanded(
            child: ListView(
              children: model.shows
                  .asMap()
                  .map((key, value) => MapEntry(
                      value,
                      Container(
                        child: ShowItem(
                          item: value,
                          onpress: () {},
                          deleteClick: () {
                            model.delete(value);
                          },
                        ),
                      )))
                  .values
                  .toList(),
            ),
          ),
        ],
      );
    }
  }

  @override
  AdminModel model() {
    return AdminModel();
  }
}
