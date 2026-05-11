import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  useMaterial3: true,
    scaffoldBackgroundColor: scaffoldColorW,
  appBarTheme: const AppBarTheme(
    backgroundColor: containerColorW,
    titleTextStyle: TextStyle(color: Colors.black,
        fontSize: 30,fontWeight: FontWeight.bold ),
    iconTheme: IconThemeData(
      color: Colors.black),
    centerTitle: true,
  ),bottomNavigationBarTheme:
const BottomNavigationBarThemeData(backgroundColor: scaffoldColorW1),
  colorScheme: const ColorScheme.light(
    surface: scaffoldColorW,                           // for scaffold Background Color
    onSurface: lightTextColorB,                        // for text color
    primary: scaffoldColorW1,                         // for appBar Background Color
    onPrimary: lightTextColorB,                      // for appBar text color
    secondary: containerColorW,                        // For Container Background Color
    onSecondary: lightTextColorW,                  // For Button Text Color
    error: Colors.white,                          // For Error Background Color
    onError: Colors.red,                         // For Error Text Color
    secondaryContainer: lightBackColorGr,         //  For Containers  color
    onSecondaryContainer: lightTextColorB,     //  For Containers Text color

  ),
    datePickerTheme: DatePickerThemeData(
  headerBackgroundColor: Colors.blue, // Header ka color
  headerForegroundColor: Colors.white, // Header text
  backgroundColor: scaffoldColorW, // Calendar background
  cancelButtonStyle: TextButton.styleFrom(foregroundColor: Colors.blue),
  confirmButtonStyle: TextButton.styleFrom(foregroundColor: Colors.blue),

)
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  useMaterial3: true,

  scaffoldBackgroundColor: darkScaffoldColorB1,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkScaffoldColorB1,
    titleTextStyle: TextStyle(color: darkTextColorW,
        fontSize: 30,fontWeight: FontWeight.bold ),
    iconTheme: IconThemeData(
        color: Colors.white),
    centerTitle: true,
  ),bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: darkBackColorG),
    colorScheme: const ColorScheme.dark(
        surface: darkScaffoldColorB1,                  // for scaffold Background Color
        onSurface: darkTextColorW,                    // for text color
        primary: darkScaffoldColorB1,                // for appBar Background Color
        onPrimary: darkTextColorW,                  // for appBar text color
        secondary: darkBackColorG,                   // For Container Background Color
        onSecondary: lightTextColorW,             // For Button Text Color
        error: Colors.black,                     // For Error Background Color
        onError: Colors.red,                    // For Error Text Color
        secondaryContainer: darkBackColorG,    //  For Container color
      onSecondaryContainer: darkTextColorW    //  For Containers Text color

    ),
  datePickerTheme: DatePickerThemeData(
    headerBackgroundColor: Colors.blueAccent,
    headerForegroundColor: Colors.white,
    backgroundColor: darkScaffoldColorB1,
    cancelButtonStyle: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
    confirmButtonStyle: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
  ),

);