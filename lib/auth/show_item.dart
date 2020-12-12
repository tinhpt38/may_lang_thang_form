import 'package:flutter/material.dart';
import 'package:may_lang_thang/model/show.dart';

class ShowItem extends StatelessWidget {
  final Show item;
  final VoidCallback onpress;
  final VoidCallback deleteClick;

  ShowItem({this.item, this.onpress, this.deleteClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: Color(0xff99f3bd),
          border: Border.all(color: Colors.black38, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.singer,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Ngày diễn: ${item.buildDate}"),
                ),
                Spacer(),
                InkWell(
                  onTap: deleteClick,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xfffe7171),
                      shape: BoxShape.circle,
                    ),
                    child: Text('x'),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Khu vip: ${item.vipRent}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Khu phổ thông: ${item.midRent}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Khu khán đài: ${item.normalRent}"),
            ),
          ],
        ),
      ),
    );
  }
}
