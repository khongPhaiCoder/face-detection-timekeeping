import 'dart:io';

import 'package:flutter/material.dart';

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
}
