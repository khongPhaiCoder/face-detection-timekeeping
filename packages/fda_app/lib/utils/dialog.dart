import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class DialogUtil {
  Future<bool> alertDialog(BuildContext context, String content) async {
    bool confirm = false;
    await showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 27, horizontal: 15),
              actionsPadding: const EdgeInsets.fromLTRB(30, 10, 30, 40),
              backgroundColor: Color(0xFFFFFFFF).withOpacity(0.95),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0))),
              content: Text(content,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF5F5F5F),
                      fontFamily: "Open Sans"),
                  textAlign: TextAlign.center),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                          border: Border.all(color: const Color(0XFFCECECE))),
                      width: 80,
                      height: 26,
                      alignment: Alignment.center,
                      child: const Text('Đồng ý',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF5F5F5F),
                              fontFamily: "Open Sans"))),
                  onTap: () {
                    confirm = true;
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                          border: Border.all(color: const Color(0XFFCECECE))),
                      width: 80,
                      height: 26,
                      alignment: Alignment.center,
                      child: const Text('Hủy',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF5F5F5F),
                              fontFamily: "Open Sans"))),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )));
    return confirm;
  }

  void showError(BuildContext context, String? content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: Color(0xFF656464).withOpacity(0.6),
      // margin: const EdgeInsets.only(bottom: 100, left: 30, right: 30),
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(60))),
      behavior: SnackBarBehavior.fixed,
      content: Text(content ?? "Có lỗi xảy ra!"),
    ));
  }

   Future<String> showDateSearch(
      BuildContext context) async {
    String selectedItem = "";
    DateTime now = new DateTime.now();
    late String monthChoose =now.month.toString().length == 1
                ? "0" + now.month.toString()
                : now.month.toString();
       
    late int yearChoose = now.year;
    await showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(20, 27, 20, 19),
              actionsPadding: const EdgeInsets.fromLTRB(30, 10, 30, 40),
              backgroundColor:Color(0xFFFFFFFF).withOpacity(0.95),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0))),
              content: Container(
                  height: 140,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Tháng",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(0xFF0DA9AB),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.33,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: WheelChooser(
                                    itemSize: 40,
                                    isInfinite: true,
                                    datas: [
                                      "01",
                                      "02",
                                      "03",
                                      "04",
                                      "05",
                                      "06",
                                      "07",
                                      "08",
                                      "09",
                                      "10",
                                      "11",
                                      "12"
                                    ],
                                    startPosition: int.parse(monthChoose) - 1,
                                    onValueChanged: (a) => {monthChoose = a},
                                    unSelectTextStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5F5F5F),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.33,
                                    ),
                                    selectTextStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xFF0DA9AB),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.33,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Năm ",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color:Color(0xFF0DA9AB),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.33,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: WheelChooser.integer(
                                    itemSize: 40,
                                    isInfinite: true,
                                    maxValue: now.year,
                                    minValue: 2010,
                                    step: 1,
                                    initValue: yearChoose,
                                    onValueChanged: (a) => {yearChoose = a},
                                    unSelectTextStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5F5F5F),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.33,
                                    ),
                                    selectTextStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xFF0DA9AB),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.33,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ],
                  )),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                          border: Border.all(color: const Color(0XFFCECECE))),
                      width: 80,
                      height: 26,
                      alignment: Alignment.center,
                      child: const Text('Đồng ý',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF5F5F5F),
                              fontFamily: "Open Sans"))),
                  onTap: () {
                    selectedItem = 
                         monthChoose.toString()+ "/" +yearChoose.toString()  ;
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                          border: Border.all(color: const Color(0XFFCECECE))),
                      width: 80,
                      height: 26,
                      alignment: Alignment.center,
                      child: const Text('Hủy',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF5F5F5F),
                              fontFamily: "Open Sans"))),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )));
    return selectedItem;
  }
}
