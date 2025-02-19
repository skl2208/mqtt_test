// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mqtt_test/util/appstyle.dart';

Future<void> skDialog(BuildContext context, String msg,
    {String typeofmsg = "OK"}) {
  return showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Stack(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  decoration: BoxDecoration(
                    color:
                        typeofmsg == "OK" ? Colors.white : Colors.red.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      msg,
                      style: Main_Style().normalText,
                    ),
                  ),
                ),
              ),
            ]),
          ));
}

Future<void> showAppConfirm({
  required BuildContext context,
  required String msg,
  required Function action1,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet = screenWidth > 450 ? true : false;
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shadowColor: Colors.grey.shade500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      titleTextStyle: TextStyle(
          fontFamily: "Kanit", fontSize: 20, color: Colors.orange.shade700),
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Icon(Icons.warning_rounded, size: 80, color: Colors.orange.shade700),
          const Text(
            "กรุณายืนยัน ",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      content: SizedBox(
          width: isTablet ? screenWidth / 2 : screenWidth / 1.5,
          child: Text(
            msg,
            style: TextStyle(
                fontFamily: "Kanit", fontSize: 15, color: Colors.grey.shade800),
          )),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(20.0),
      actions: [
        ElevatedButton(
            style: Main_Style().buttonCancelStyle,
            onPressed: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "ยกเลิก",
                style: Main_Style().textBtn1,
              ),
            )),
        ElevatedButton(
            style: Main_Style().buttonStyle1,
            onPressed: () {
              action1();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "ยืนยัน",
                style: Main_Style().textBtn1,
              ),
            )),
      ],
    ),
  );
}

Future<void> showAppAlert({
  required BuildContext context,
  required String headline,
  required String msg,
  required String typeofmsg,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shadowColor: Colors.grey.shade500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      titleTextStyle: TextStyle(
          fontFamily: "Kanit", fontSize: 20, color: Colors.orange.shade700),
      titlePadding: const EdgeInsets.all(10.0),
      title: Column(
        children: [
          Icon(
              typeofmsg == "WARN"
                  ? Icons.warning_rounded
                  : typeofmsg == "OK"
                      ? Icons.check_circle_outline_outlined
                      : Icons.highlight_remove,
              size: 80,
              color: typeofmsg == "WARN"
                  ? Colors.orange.shade700
                  : typeofmsg == "OK"
                      ? Colors.green.shade700
                      : Colors.red.shade700),
          Text(
            headline,
            style: TextStyle(
                fontSize: 18,
                color: typeofmsg == "WARN"
                    ? Colors.orange.shade700
                    : typeofmsg == "OK"
                        ? Colors.green.shade700
                        : Colors.red.shade700),
          ),
        ],
      ),
      content: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          width: MediaQuery.of(context).size.width / 2,
          child: Text(
            msg,
            style: TextStyle(
                fontFamily: "Kanit", fontSize: 15, color: Colors.grey.shade800),
          )),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: const EdgeInsets.all(20.0),
      actions: [
        ElevatedButton(
            style: Main_Style().buttonStyle1,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "ปิดหน้าต่าง",
                style: Main_Style().textBtn1,
              ),
            )),
      ],
    ),
  );
}

Future<void> showAppWarn({
  required BuildContext context,
  String title = "",
  required String msg,
  required String typeofmsg,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet = screenWidth > 450 ? true : false;
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shadowColor: Colors.grey.shade500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      titleTextStyle: TextStyle(
          fontFamily: "Kanit", fontSize: 20, color: Colors.orange.shade700),
      titlePadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      title: Column(
        children: [
          Icon(
              typeofmsg == "OK"
                  ? Icons.check_circle_outline
                  : typeofmsg == "NOTOK"
                      ? Icons.highlight_remove
                      : Icons.warning_amber_rounded,
              size: 80,
              color: typeofmsg == "OK"
                  ? Colors.green.shade700
                  : typeofmsg == "NOTOK"
                      ? Colors.red.shade600
                      : Colors.orange.shade600),
          title != ""
              ? Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color_Style().colorOKButton,
                      fontWeight: FontWeight.bold),
                )
              : Container(),
        ],
      ),
      content: SizedBox(
          width: double.maxFinite,
          child: Text(
            textAlign: TextAlign.start,
            msg,
            style: TextStyle(
                fontFamily: "Kanit", fontSize: 15, color: Colors.grey.shade800),
          )),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(20.0),
      actions: [
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
              style: Main_Style().buttonStyle1,
              onPressed: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "ปิด",
                  style: Main_Style().textBtn1,
                ),
              )),
        ),
      ],
    ),
  );
}

Future<void> showAppWarnDebug({
  required BuildContext context,
  String title = "",
  required String msg,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.orange.shade100,
      shadowColor: Colors.grey.shade500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      titleTextStyle: TextStyle(
          fontFamily: "Kanit", fontSize: 20, color: Colors.orange.shade700),
      titlePadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      title: Column(
        children: [
          Icon(Icons.highlight_remove, size: 80, color: Colors.red.shade600),
          title != ""
              ? Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color_Style().colorOKButton,
                      fontWeight: FontWeight.bold),
                )
              : Container(),
        ],
      ),
      content: SizedBox(
          width: double.maxFinite,
          child: Text(
            textAlign: TextAlign.start,
            msg,
            style: TextStyle(
                fontFamily: "Kanit", fontSize: 15, color: Colors.grey.shade800),
          )),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(20.0),
      actions: [
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
              style: Main_Style().buttonStyle1,
              onPressed: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "ปิด",
                  style: Main_Style().textBtn1,
                ),
              )),
        ),
      ],
    ),
  );
}

showAppToast(
    {required BuildContext context,
    required String msg,
    String typeofmsg = "OK"}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                typeofmsg == "OK"
                    ? Icons.check
                    : typeofmsg == "NOTOK"
                        ? Icons.close
                        : Icons.priority_high,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10.0,
                height: 10.0,
              ),
              Flexible(
                child: Text(
                  msg,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: typeofmsg == "OK"
            ? Colors.green
            : typeofmsg == "NOTOK"
                ? Colors.red
                : Colors.orange.shade700,
        duration: const Duration(seconds: 2)),
  );
}
