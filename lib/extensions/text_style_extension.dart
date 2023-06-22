
import 'package:flutter/material.dart';
import 'package:test_flutter_ver1/constants/constants.dart';

extension XTextStyle on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get extraBlack => copyWith(fontWeight: FontWeight.w900);

  TextStyle get grey => copyWith(color: AppThemes.grey);
  TextStyle get white => copyWith(color: AppThemes.white);
  TextStyle get red => copyWith(color: Colors.red);
}
