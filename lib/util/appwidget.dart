// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mqtt_test/util/appstyle.dart';

SizedBox spaceBox(double heightpixel) {
  return SizedBox(
    width: double.infinity,
    height: heightpixel,
  );
}

InputDecoration appInputDecorationTextForm(
    String labelText, Icon prefixicon, Icon suffixicon) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(3.0),
    errorStyle: Main_Style().errorStyle,
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color_Style().colorBGFocus, width: 2.5),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color_Style().colorBorder),
      borderRadius: BorderRadius.circular(5),
    ),
    hintText: labelText,
    // labelText: labelText,
    labelStyle: Main_Style().normalText,
    focusColor: Color_Style().colorBGFocus,
    hoverColor: Color_Style().colorBGFocus,
    // ignore: unnecessary_null_comparison
    prefixIcon: (prefixicon != null)
        ? Icon(
            prefixicon.icon,
            color: Color_Style().colorBorder,
            size: 20.0,
          )
        : const Icon(null),
    // ignore: unnecessary_null_comparison
    prefixIconConstraints: (prefixicon != null)
        ? const BoxConstraints.expand(width: 48, height: 48)
        : const BoxConstraints(maxHeight: 0, maxWidth: 0),
    // ignore: unnecessary_null_comparison
    // suffixIcon: (suffixicon != null)
    //     ? Icon(
    //         suffixicon.icon,
    //       )
    //     : const Icon(null),
    fillColor: Colors.white,
    filled: true,
  );
}

InputDecoration inputDisableDecorationTextForm(
    String labelText, Icon prefixicon, Icon suffixicon) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(5.0),
    errorStyle: Main_Style().errorStyle,
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color_Style().colorBGFocus, width: 2.5),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color_Style().colorBorder),
      borderRadius: BorderRadius.circular(5),
    ),
    hintText: labelText,
    // labelText: labelText,
    labelStyle: Main_Style().normalText,
    focusColor: Color_Style().colorBGFocus,
    hoverColor: Color_Style().colorBGFocus,
    // ignore: unnecessary_null_comparison
    prefixIcon: (prefixicon != null)
        ? Icon(
            prefixicon.icon,
            color: Color_Style().colorBorder,
            size: 20.0,
          )
        : const Icon(null),
    // ignore: unnecessary_null_comparison
    prefixIconConstraints: (prefixicon != null)
        ? const BoxConstraints.expand(width: 48, height: 48)
        : const BoxConstraints(maxHeight: 0, maxWidth: 0),
    // ignore: unnecessary_null_comparison
    suffixIcon: (suffixicon != null)
        ? Icon(
            suffixicon.icon,
          )
        : const Icon(null),
    fillColor: Colors.grey.shade200,
    filled: true,
  );
}

SnackBar appSnackBar(String msg) {
  return SnackBar(
    backgroundColor: Color_Style().colorOKButton,
    content: Text(
      msg,
      style: Main_Style().textButton1,
    ),
    duration: const Duration(milliseconds: 500),
  );
}

showCircularProgress({Color? colorCircular, String? msg = "กำลังทำงาน..."}) {
  colorCircular ??= Colors.blue.shade700;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        color: colorCircular,
      ),
      spaceBox(10.0),
      Text(
        msg!,
        style: TextStyle(
          color: colorCircular,
          fontSize: 13.0,
          fontFamily: "Prompt",
        ),
      ),
    ],
  );
}

class ShowCircularProgress extends StatelessWidget {
  ShowCircularProgress({this.msg = "กำลังทำงาน...", super.key});

  String? msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.blue.shade800,
          ),
          spaceBox(10.0),
          Text(
            "กำลังทำงาน...",
            style: TextStyle(
              color: Colors.blue.shade800,
              fontSize: 13.0,
              fontFamily: "Prompt",
            ),
          ),
        ],
      ),
    );
  }
}
