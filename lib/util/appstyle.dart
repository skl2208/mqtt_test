// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

class Color_Style {
  //=== Background ===
  final bgColor = Colors.grey.shade100;
  //==== Font Style ====
  // final colorFontBody = const Color.fromARGB(255, 65, 64, 64);
  final colorFontBody = Colors.grey.shade700;
  final colorFontHeader = Colors.white;
  final colorOutstandingFont = const Color.fromARGB(255, 73, 105, 233);

  //==== Icon Style ====
  final colorIconTheme = const Color.fromARGB(255, 65, 64, 64);

  //==== Border Style ====
  final colorBorder = const Color.fromARGB(255, 191, 191, 192);
  final colorBorderFocus = const Color.fromARGB(255, 73, 105, 233);

  //==== Button Style ====
  final colorOKButton = Colors.blue.shade500;
  final colorSaveButton = Colors.green.shade500;
  final colorRemoveButton = Colors.red;
  final colorCancelButton = const Color.fromARGB(255, 122, 122, 124);

  //==== Other Style ====
  final colorTitle = Colors.white;
  final colorBGDrawer = Colors.blue.shade800;
  final colorBGProfile = Colors.blue.shade200;
  final colorFontDrawer = Colors.white;
  final colorBGAppBar = Colors.white;
  final colorBGFocus = const Color.fromARGB(255, 173, 188, 250);
  final errorStyle = const TextStyle(
    color: Colors.red,
  );
  final colorOK = const Color.fromARGB(250, 67, 160, 72);
  final colorNOTOK = const Color.fromARGB(250, 229, 56, 53);
  final colorWARN = const Color.fromARGB(250, 216, 117, 5);

  //=== Header ===//
  final colorHeader = Colors.white;
  final bgColorHeader = const Color.fromARGB(255, 22, 2, 80);

  //=== Home Page Label ===//
  final colorHomePageLabel = Colors.blue.shade700;
  final colorHomePageLabel2 = Colors.red.shade700;

  Color_Style();
}

class Main_Style {
  final title = TextStyle(
    fontFamily: "Kanit",
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorOutstandingFont,
  );
  final biggernormalText = TextStyle(
    fontFamily: "Kanit",
    fontSize: 18,
    color: Color_Style().colorFontBody,
  );
  final normalText = TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
    color: Color_Style().colorFontBody,
  );
  final normalBoldText = TextStyle(
    fontFamily: "Kanit-Bold",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorFontBody,
  );
  final hintText = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 14,
    color: Colors.white,
  );
  final highlightText = TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
    color: Color_Style().colorOutstandingFont,
  );
  final underline = TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
    decoration: TextDecoration.underline,
    color: Color_Style().colorFontBody,
  );
  final headerText = TextStyle(
    fontFamily: "Kanit",
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorFontBody,
  );
  final footerText = TextStyle(
    fontFamily: "Kanit",
    fontSize: 12,
    color: Color_Style().colorFontBody,
  );
  final myStyle1 = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
  );
  final myStyle3 = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
  );
  final myLabelStyle1 = TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorFontBody,
  );
  final myLabelStyle1InActivate = TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade500,
  );
  final myLabelStyle2 = TextStyle(
    fontFamily: "Kanit",
    fontSize: 19,
    fontWeight: FontWeight.normal,
    color: Color_Style().colorHomePageLabel,
  );
  final myLabelStyle2_2 = TextStyle(
    fontFamily: "Kanit",
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorHomePageLabel2,
  );
  final myLabelStyle3 = TextStyle(
    fontFamily: "Kanit",
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorFontBody,
  );
  final labelBottomStyle1 = TextStyle(
    fontFamily: "Kanit",
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorFontBody,
  );
  final textButton1 = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 16,
  );
  final textBtn1 = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 16.0,
    color: Colors.white,
  );
  final titlePage = TextStyle(
      fontFamily: "Kanit",
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color_Style().colorTitle);
  final titleGreenPage = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );
  final alertText = const TextStyle(
    fontFamily: "Kanit",
    color: Colors.red,
  );
  final outstandingText = TextStyle(
    fontFamily: "Kanit",
    color: Color_Style().colorOutstandingFont,
  );
  final listMenuDrawer = TextStyle(
    fontFamily: "Kanit",
    fontSize: 14,
    color: Color_Style().colorFontBody,
  );
  final toast = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 13,
    color: Colors.white,
  );
  final errorStyle = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 12,
    color: Colors.red,
  );
  final circularText = const TextStyle(
    fontFamily: "Kanit",
    fontSize: 12,
  );
  final headlineNews = const TextStyle(
      fontFamily: "Kanit",
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue);
  final allNews = const TextStyle(
      fontFamily: "Kanit",
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.blue);
  final topicNews = TextStyle(
      fontFamily: "Kanit",
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade700);
  final btn1Style = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  );

  final buttonTransparentStyle = ButtonStyle(
    textStyle: WidgetStateProperty.all(
      TextStyle(
        color: Color_Style().colorFontBody,
      ),
    ),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(3.0)),
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
  );

  final buttonStyle1 = ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.all(10.0),
    ),
    backgroundColor: WidgetStateProperty.all(Colors.blue.shade500),
  );
  final buttonCancelStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(10.0)),
    backgroundColor: WidgetStateProperty.all(Colors.grey.shade500),
  );
  final buttonAlertStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    padding: const WidgetStatePropertyAll(EdgeInsets.all(10.0)),
    backgroundColor: WidgetStateProperty.all(Colors.red),
  );
  Main_Style();
}

class DrawerStyle {
  final headerText = TextStyle(
    fontFamily: "Kanit",
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color_Style().colorFontDrawer,
  );
  final listTileText = TextStyle(
    fontFamily: "Kanit",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Color_Style().colorFontBody,
  );
  DrawerStyle();
}

class ButtonBackgroundColor {
  final OkBtn = const Color.fromARGB(255, 42, 185, 252);
}

class ButtonStyleShow {
  static final notfounddata = ButtonStyle(
      padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0)),
      backgroundColor: WidgetStatePropertyAll(Colors.grey.shade700),
      side: WidgetStatePropertyAll(BorderSide(
        color: Colors.grey.shade700,
      )));
}
