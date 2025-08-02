import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customText({
  required String text,
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
  double? lineHeight,
  FontStyle? fontStyle,
  TextDecoration? decoration,
  Color? decorationColor,
  TextAlign? textAlign,
  bool? softWrap,
  TextOverflow overflow= TextOverflow.clip,
}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: fontWeight,
      decoration: decoration,
      fontSize: fontSize.sp,
      color: color,
      height: lineHeight?.h,
      fontStyle: fontStyle,
      decorationColor: decorationColor,
    ),

    textAlign: textAlign,
    softWrap: softWrap,
    overflow: overflow,
  );
}
