import 'package:flutter/material.dart';

const defaultTextStyle = TextStyle(
  fontFamily: 'NotoSansKR',
  overflow: TextOverflow.ellipsis,
  letterSpacing: 0,
  height: 1
);

extension StyleText on TextTheme {
  TextStyle get thin => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w100,
      // height: 1.17
  );
  TextStyle get light => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w300,
      // height: 1.17
  );
  TextStyle get regular => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w400,
      // height: 1.17
  );
  TextStyle get medium => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w500,
      // height: 1.17
  );
  TextStyle get bold => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w700,
      // height: 1.17
  );
  TextStyle get black => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w900,
      // height: 1.17
  );
}
