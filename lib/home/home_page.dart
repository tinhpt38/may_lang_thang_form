import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:matt_q/matt_q.dart';
import 'package:may_lang_thang/auth/admin_page.dart';
import 'package:may_lang_thang/components/button.dart';
import 'package:may_lang_thang/components/input.dart';
import 'package:may_lang_thang/home/home_page_model.dart';
import 'package:may_lang_thang/home/home_page_model.dart' as step;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MattQ<HomePage, HomeModel> {
  HomeModel _model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _model.getShow();
    });
  }

  @override
  Function(BuildContext context, HomeModel model, Widget child) builder() {
    return (context, model, child) {
      _model = model;
      Future.delayed(Duration.zero, () async {
        if (model.error) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: model.errMessage,
            ),
          );
          model.setError(false);
        }
        if (model.isSending) {
          showTopSnackBar(
              context,
              CustomSnackBar.info(
                message: "Đang gửi email xác nhận yêu cầu!",
              ));
        }
        if (!model.isSending && model.mailSuccess) {
          showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "Gửi email thành công! Đang mở Zalo",
              ));
        }
        if (model.mailSuccess) {
          String url = "https://zalo.me/0969896164";
          if (await canLaunch(url)) {
            Future.delayed(Duration(milliseconds: 1000), () {
              launch(url);
            });
          } else {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: "Không thể mở Zalo",
              ),
            );
          }
        }
        if (model.loginSuccess) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AdminPage()));
          model.setLoginSuccess(false);
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

  @override
  HomeModel model() {
    return HomeModel();
  }

  List<Widget> buildStepMobile(HomeModel model, Size size) {
    switch (model.currentStep) {
      case step.Step.landing:
        return buildLanding(model);
        break;
      case step.Step.name:
        return buildName(model, size);
      case step.Step.phone:
        return buildPhone(model, size);
      case step.Step.show:
        return buildSelectShow(model);
      case step.Step.rent:
        return buildRent(model);
      case step.Step.indexi:
        return buildIndexi(model);
      case step.Step.submit:
        return buildNote(model);
      default:
        return [];
    }
  }

  List<Widget> buildStepWeb(HomeModel model, Size size) {
    if (model.isStepLogin) {
      return buildLogin(model);
    }
    switch (model.currentStep) {
      case step.Step.landing:
        return buildLanding(model)..add(buildBottom(model));
      case step.Step.name:
        return buildName(model, size)..add(buildBottom(model));
      case step.Step.phone:
        return buildPhone(model, size)..add(buildBottom(model));
      case step.Step.show:
        return buildSelectShow(model);
      case step.Step.rent:
        return buildRentWeb(model, size);
      case step.Step.indexi:
        return buildIndexWeb(model, size);
      case step.Step.submit:
        return buildNote(model)..add(buildBottom(model));
      default:
        return [];
    }
  }

  Widget controllButton(HomeModel model) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            onPressed: model.backStep,
            child: Text("Back"),
          ),
          Button(
            onPress: model.nextStep,
            label: "Continue",
          ),
        ],
      ));

  List<Widget> buildLanding(HomeModel model) {
    return [
      Text("CÁCH ĐẶT CHỖ NGỒI",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 32),
        child: Text(
            "B1: Click vào đường link và điền thông tin vào form (Họ và tên, SĐT, Khu ngồi và số ghế)"),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
        child: Text("B2: Chuyển khoản vào tài khoản"),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
          child: Wrap(
            children: [
              Text("Chủ tài khoản:"),
              Text("HOÀNG THIÊN ÂN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          )),
      Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
          child: Wrap(
            children: [
              Text("Vietcombank:"),
              SelectableText("0561000620269",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          )),
      Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
          child: Wrap(
            children: [
              Text("Chi nhánh:"),
              Text("Lâm Đồng",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          )),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
        child: Text("B3: Gửi hình ảnh chuyển khoảng thành công vào ZALO:"),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 12, right: 24),
        child: SelectableText(
          "0969896164",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
        child: Text("B4: Click vào nút Submit form này."),
      ),
      Center(
        child: Button(
          onPress: model.nextStep,
          label: "Continue",
        ),
      ),
    ];
  }

  Widget buildPictureCoverMobile(HomeModel model, Size size) {
    if (model.currentStep == step.Step.indexi ||
        model.currentStep == step.Step.rent) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: buildPrictureIndex(size),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: buildPictureMainLogo(model, size),
    );
  }

  Widget buildPictureMainLogoWeb(HomeModel model, Size size) => Container(
        height: size.height * 1 / 3,
        child: Image.asset(
          "assets/images/logo_top_web.png",
          scale: 2,
        ),
      );

  Widget buildPictureMainLogo(HomeModel model, Size size) => Container(
        height: size.height * 1 / 4,
        child: Image.asset(
          "assets/images/logo_top.png",
          scale: 0.8,
        ),
      );

  Widget buildPrictureIndex(Size size) => Container(
        height: size.height * 1 / 2,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/index.png",
              scale: 0.8,
            ),
          ],
        ),
      );

  Widget buildBottom(HomeModel model) => Container(
        margin: const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 12),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1))),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    child: Image.asset(
                  "assets/images/logo_bot.png",
                  scale: 4.5,
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hotline"),
                        SelectableText("0877339889",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        SelectableText("0777796007",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: !model.isStepLogin,
              child: InkWell(
                onTap: () {
                  model.setIsStepLogin(true);
                },
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      );

  List<Widget> buildName(HomeModel model, Size size) => [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text("HỌ VÀ TÊN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Input(title: "HỌ VÀ TÊN", controller: model.nameController),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: controllButton(model),
        ),
        SizedBox(
          width: size.width,
          height: size.height * 1 / 5,
        ),
      ];

  List<Widget> buildPhone(HomeModel model, Size size) => [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text("SỐ ĐIỆN THOẠI",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child:
              Input(title: "SỐ ĐIỆN THOẠI", controller: model.phoneController),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: controllButton(model),
        ),
        SizedBox(
          width: size.width,
          height: size.height * 1 / 5,
        ),
      ];
  List<Widget> buildSelectShow(HomeModel model) => [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text("TÊN CA SĨ (Tiếng Việt có dấu)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Input(
            title: "Ví dụ: Bùi Anh Tuấn",
            controller: model.showControler,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text("NGÀY DIỄN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
        controllButton(model),
      ];

  List<Widget> buildRent(HomeModel model) => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Bảng giá chỗ ngồi",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Show diễn ca sĩ: ${model.selectShow.singer}",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Ngày diễn: ${model.buildDate}",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ListTile(
          title: Text("Khu VIP - ${model.selectShow.vipRent} VNĐ"),
          leading: Radio(
            value: step.IndexValue.vip,
            groupValue: model.indexValue,
            onChanged: model.onIndexValueChange,
          ),
        ),
        ListTile(
          title: Text("Khu Lang Thang - ${model.selectShow.midRent} VNĐ"),
          leading: Radio(
            value: step.IndexValue.mid,
            groupValue: model.indexValue,
            onChanged: model.onIndexValueChange,
          ),
        ),
        ListTile(
          title: Text("Khu khán đài - ${model.selectShow.normalRent} VNĐ"),
          leading: Radio(
            value: step.IndexValue.low,
            groupValue: model.indexValue,
            onChanged: model.onIndexValueChange,
          ),
        ),
        ListTile(
            title: Text("Chọn khi xác nhận"),
            leading: Radio(
              value: step.IndexValue.option,
              groupValue: model.indexValue,
              onChanged: model.onIndexValueChange,
            )),
        controllButton(model),
      ];

  List<Widget> buildIndexi(HomeModel model) => [
        Text("Chọn vị trí ngồi:",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Ví dụ: Khu vip B2-B5"),
        Input(
          title: "Nhập khu và tổng số ghế",
          controller: model.indexController,
        ),
        SizedBox(
          width: double.infinity,
          height: 120,
        ),
        controllButton(model)
      ];

  List<Widget> buildNote(HomeModel model) => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Lưu ý",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "Đạt chỗ thành công chỉ khi khách hàng đã thanh toán thành công."),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Kiểm tra chính xác sđt và xác nhận trên zalo."),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "Sau khi hoàn thành xong form trên quý khách có 12 tiếng để thanh toán. Nếu quá thời gian thì sẽ huỷ chỗ ngồi."),
        ),
        SizedBox(
          width: double.infinity,
          height: 100,
        ),
        Center(
          child: Button(
            onPress: () async {
              await model.mailto();
            },
            label: "Submit",
          ),
        ),
      ];

  List<Widget> buildIndexWeb(HomeModel model, Size size) => [
        Row(
          children: [
            Expanded(flex: 2, child: buildPrictureIndex(size)),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildIndexi(model)..add(buildBottom(model)),
                ),
              ),
            ),
          ],
        ),
      ];

  List<Widget> buildRentWeb(HomeModel model, Size size) => [
        Row(
          children: [
            Expanded(flex: 2, child: buildPrictureIndex(size)),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(right: 32),
                child: Column(
                  children: buildRent(model)..add(buildBottom(model)),
                ),
              ),
            ),
          ],
        ),
      ];

  List<Widget> buildLogin(HomeModel model) => [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "ĐĂNG NHẬP",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Input(
            controller: model.userController,
            title: "TÊN ĐĂNG NHẬP",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Input(
            controller: model.pwdController,
            title: "MẬT KHẨU",
            obscureText: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Button(label: "ĐĂNG NHẬP", onPress: model.login),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              model.setIsStepLogin(false);
            },
            child: Text("Tiếp tục đăng kí chỗ ngồi"),
          ),
        )
      ];

  double getWidthWeb(HomeModel model, Size size) {
    if (model.currentStep == step.Step.indexi ||
        model.currentStep == step.Step.rent) {
      return size.width * 1 / 2;
    } else {
      return size.width * 1 / 4;
    }
  }

  Widget buildDesktop(BuildContext context, HomeModel model) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            buildPictureMainLogoWeb(model, size),
            Center(
              child: Container(
                width: getWidthWeb(model, size),
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(42),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(5, 5))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildStepWeb(model, size),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMobile(BuildContext context, HomeModel model) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          margin:
              const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(42),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black38, blurRadius: 6, offset: Offset(5, 5))
              ]),
          child: ListView(
            children: [
              buildPictureCoverMobile(model, size),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildStepMobile(model, size),
                ),
              ),
              buildBottom(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTablet(BuildContext context, HomeModel model) {
    return buildDesktop(context, model);
  }
}
