import 'package:flutter/material.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/colors_app.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';

class AppStyles {
  static AppStyles? _instance;
  // Avoid self isntance
  AppStyles._();

  static AppStyles get instance {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton =>
      ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7)
        ),
        backgroundColor: ColorsApp.instance.primary,
        textStyle: TextStyles.instance.textButtonLabel);
}

extension AppStylesExcetions on BuildContext{
    AppStyles get appStyles => AppStyles.instance;
  }
