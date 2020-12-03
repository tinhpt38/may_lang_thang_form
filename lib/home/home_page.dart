import 'package:flutter/material.dart';
import 'package:matt_q/matt_q.dart';
import 'package:may_lang_thang/components/button.dart';
import 'package:may_lang_thang/components/input.dart';
import 'package:may_lang_thang/home/home_page_model.dart';
import 'package:may_lang_thang/home/home_page_model.dart' as step;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MattQ<HomePage, HomeModel> {
  @override
  Function(BuildContext context, HomeModel model, Widget child) builder() {
    return (context, model, child) {
      Size size = MediaQuery.of(context).size;
      Future.delayed(Duration.zero, () {
        if (model.error) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: model.errMessage,
            ),
          );
          model.setError(false);
        }
      });
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
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
              buildPictureCover(model, size),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildStep(model, size),
                ),
              ),
              buildBottom(),
            ],
          ),
        ),
      );
    };
  }

  @override
  HomeModel model() {
    return HomeModel();
  }

  List<Widget> buildStep(HomeModel model, Size size) {
    switch (model.currentStep) {
      case step.Step.landing:
        return buildLanding(model);
        break;
      case step.Step.name:
        return buildName(model, size);
      case step.Step.phone:
        return buildPhone(model, size);
      case step.Step.rent:
        return buildRent(model);
      case step.Step.indexi:
        return buildIndexi(model);
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
            "B1: Click vào đường link và điền thông tin vào form (Họ và tên, SĐT, Khu ngồi và số ghế"),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
        child: Text("B2: Chuyển khoản vào tài khoản"),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
        child: Text(
            "Chủ tài khoảng: PHAN TRUNG TÍNH \nAgribank: 5400205376050 \nChi nhánh: Lâm Đồng"),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
        child: Text("B3: Gửi hình ảnh chuyển khoảng thành công vào ZALO:"),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 12, right: 24),
        child: SelectableText(
          "0352974899",
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

  Widget buildPictureCover(HomeModel model, Size size) {
    if (model.currentStep == step.Step.indexi ||
        model.currentStep == step.Step.rent) {
      return buildPrictureIndex(size);
    }
    return buildPictureMainLogo(size);
  }

  Widget buildPictureMainLogo(Size size) => Container(
        height: size.height * 1 / 4,
        child: Image.asset(
          "assets/images/logo_top.png",
          scale: 0.8,
        ),
      );

  Widget buildPrictureIndex(Size size) => Container(
        height: size.height * 1 / 3,
        child: Image.asset(
          "assets/images/index.png",
          scale: 0.8,
        ),
      );

  Widget buildBottom() => Container(
        margin: const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 12),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1))),
        child: Row(
          children: [
            Container(
                child: Image.asset(
              "assets/images/logo_bot.png",
              scale: 0.5,
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hotline"),
                    Text(
                      "09xx.xxx.xxx (Mr. Ân Hoàng)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text("09xx.xxx.xxx (Mrs. Giang)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  List<Widget> buildName(HomeModel model, Size size) => [
        Text("HỌ VÀ TÊN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Input(title: "HỌ VÀ TÊN", controller: model.nameController),
        controllButton(model),
        SizedBox(
          width: size.width,
          height: size.height * 1 / 5,
        ),
      ];

  List<Widget> buildPhone(HomeModel model, Size size) => [
        Text("SỐ ĐIỆN THOẠI",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Input(title: "SỐ ĐIỆN THOẠI", controller: model.phoneController),
        controllButton(model),
        SizedBox(
          width: size.width,
          height: size.height * 1 / 5,
        ),
      ];

  List<Widget> buildRent(HomeModel model) => [
        Text("Bảng giá chỗ ngồi",
            style: TextStyle(fontWeight: FontWeight.bold)),
        ListTile(
          title: Text("Ghế VIP"),
          leading: Radio(
            value: step.IndexValue.vip,
            groupValue: model.indexValue,
            onChanged: model.onIndexValueChange,
          ),
        ),
        ListTile(
          title: Text("Ghế Phổ thông"),
          leading: Radio(
            value: step.IndexValue.mid,
            groupValue: model.indexValue,
            onChanged: model.onIndexValueChange,
          ),
        ),
        ListTile(
          title: Text("Ghế khán đài"),
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
        controllButton(model)
      ];
}
