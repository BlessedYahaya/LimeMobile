import 'package:flutter/material.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/strings.dart';

ThemeData baseTheme(BuildContext context) => ThemeData(
      fontFamily: Strings.app.font,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
      primarySwatch: LColors.primarySwatch,
      cardTheme: CardTheme(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Color(0x0FFEDF2F7), width: 1),
        ),
        elevation: 3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LColors.ashColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.normal,
          fontSize: 12,
          height: 1.6,
        ),
      ),
    );

ThemeData theme(BuildContext context) => baseTheme(context).copyWith(
      brightness: Brightness.light,
      primaryColor: LColors.primaryColor,
      highlightColor: LColors.primaryColor.withOpacity(0.3),
      errorColor: LColors.errorColor,
      appBarTheme: AppBarTheme.of(context).copyWith(
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
    );

ThemeData darkTheme(BuildContext context) => baseTheme(context).copyWith(
      brightness: Brightness.dark,
      primaryColor: LColorsDark.primaryLightColor,
      highlightColor: LColorsDark.primaryColor.withOpacity(0.3),
      errorColor: LColorsDark.errorColor,
      appBarTheme: AppBarTheme.of(context).copyWith(
        color: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
    );
