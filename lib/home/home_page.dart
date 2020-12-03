import 'package:flutter/material.dart';
import 'package:matt_q/matt_q.dart';
import 'package:may_lang_thang/components/button.dart';
import 'package:may_lang_thang/components/input.dart';
import 'package:may_lang_thang/home/home_page_model.dart';
import 'package:may_lang_thang/home/home_page_model.dart' as step;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MattQ<HomePage, HomeModel> {
  @override
  Function(BuildContext context, HomeModel model, Widget child) builder() {
    return (context, model, child) {
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
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Image.asset(
                    "assets/images/logo_top.png",
                    scale: 0.8,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: buildStep(model),
                ),
              ),
              Container(
                child: buildBottom(),
              ),
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

  Widget buildStep(HomeModel model) {
    switch (model.currentStep) {
      case step.Step.landing:
        return buildLanding(model);
        break;
      case step.Step.name:
        return buildName(model);
      case step.Step.phone:
        return buildPhone(model);
      default:
        return Container();
    }
  }

  Widget buildLanding(HomeModel model) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                Text("CÁCH ĐẶT CHỖ NGỒI",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12, bottom: 12, right: 32),
                  child: Text(
                      "B1: Click vào đường link và điền thông tin vào form (Họ và tên, SĐT, Khu ngồi và số ghế"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12, bottom: 12, right: 24),
                  child: Text("B2: Chuyển khoản vào tài khoản"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12, bottom: 12, right: 24),
                  child: Text(
                      "Chủ tài khoảng: PHAN TRUNG TÍNH \nAgribank: 5400205376050 \nChi nhánh: Lâm Đồng"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12, bottom: 12, right: 24),
                  child: Text(
                      "B3: Gửi hình ảnh chuyển khoảng thành công vào ZALO:"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 12, right: 24),
                  child: SelectableText(
                    "0352974899",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12, bottom: 12, right: 24),
                  child: Text("B4: Click vào nút Submit form này."),
                ),
              ],
            ),
          ),
        ),
        Button(
          onPress: model.nextStep,
          label: "Continue",
        ),
      ],
    );
  }

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

  Widget buildName(HomeModel model) => Container(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("HỌ VÀ TÊN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Input(title: "HỌ VÀ TÊN", controller: TextEditingController()),
              Padding(
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
                ),
              )
            ],
          ),
        ),
      );

  Widget buildPhone(HomeModel model) => Container(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SỐ ĐIỆN THOẠI",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Input(
                  title: "SỐ ĐIỆN THOẠI", controller: TextEditingController()),
              Padding(
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
                ),
              )
            ],
          ),
        ),
      );
}
