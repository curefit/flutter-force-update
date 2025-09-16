import 'package:flutter/material.dart';

class ForceUpdateConfig {
  final Widget headerWidget;
  final String updateButtonText;
  final String? laterButtonText;
  final bool forcedUpdate;
  final String? androidStoreUrl;
  final String? iosStoreUrl;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? buttonTextColor;
  final TextStyle? buttonTextStyle;
  final Color? laterButtonColor;
  final Color? updateButtonColor;
  final Function()? onUpdatePressed;
  final Function()? onLaterPressed;

  const ForceUpdateConfig({
    this.headerWidget= const Text('Update Required'),
    this.updateButtonText = 'Update Now',
    this.laterButtonText,
    this.forcedUpdate = true,
    this.onUpdatePressed,
    this.onLaterPressed,
    this.androidStoreUrl,
    this.iosStoreUrl,
    this.buttonTextColor,
    this.backgroundColor,
    this.textColor,
    this.laterButtonColor,
    this.updateButtonColor,
    this.buttonTextStyle,
  });

  ForceUpdateConfig copyWith({
    Widget? headerWidget,
    String? updateButtonText,
    String? laterButtonText,
    bool? forcedUpdate,
    Function()? onUpdatePressed,
    Function()? onLaterPressed,
    String? androidStoreUrl,
    String? iosStoreUrl,
    Color? backgroundColor,
    Color? textColor,
    Color? buttonTextColor,
    Color? laterButtonColor,
    Color? updateButtonColor,
    TextStyle? buttonTextStyle,
  }) {
    return ForceUpdateConfig(
      headerWidget: headerWidget ?? this.headerWidget,
      updateButtonText: updateButtonText ?? this.updateButtonText,
      laterButtonText: laterButtonText ?? this.laterButtonText,
      forcedUpdate: forcedUpdate ?? this.forcedUpdate,
      onUpdatePressed: onUpdatePressed ?? this.onUpdatePressed,
      onLaterPressed: onLaterPressed ?? this.onLaterPressed,
      androidStoreUrl: androidStoreUrl ?? this.androidStoreUrl,
      iosStoreUrl: iosStoreUrl ?? this.iosStoreUrl,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      laterButtonColor: laterButtonColor ?? this.laterButtonColor,
      updateButtonColor: updateButtonColor ?? this.updateButtonColor,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
    );
  }
}
