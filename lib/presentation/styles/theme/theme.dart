import 'package:flutter/material.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/appbar_theme.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/checkbox_theme.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/chip_theme.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/eleveted_button_theme.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/outlined_button_theme.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/text_field_theme.dart';
import 'package:my_project/presentation/styles/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppbarTheme.lightAppbarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevetedButtonTheme.lightElevetedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormatFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppbarTheme.darkAppbarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevetedButtonTheme.darkElevetedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormatFieldTheme.darkInputDecorationTheme,
  );
  
}
