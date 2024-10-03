import 'package:flutter/material.dart';

class MyCoustoumTheem{

  static Color mainColor = Color(0xff50A898);

  static ThemeData MyTheme = ThemeData(
      fontFamily: "CoustomFont",
      useMaterial3: true,
      appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          color: mainColor
      ),
      primaryColor:mainColor,
      scaffoldBackgroundColor: Colors.white,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: mainColor,
        selectionHandleColor: mainColor,
        selectionColor: mainColor,
      ),
       datePickerTheme: DatePickerThemeData(
         backgroundColor: mainColor,
         dayStyle: TextStyle(color: Colors.white),
        todayBorder: BorderSide.none,
         todayForegroundColor: MaterialStatePropertyAll( Colors.white),
         rangePickerHeaderForegroundColor: Colors.white
       )
  );
}