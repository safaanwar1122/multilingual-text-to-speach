import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multilingual_text_to_speech/widgets/spacer.dart';


Widget customButton({
  required String label,
  VoidCallback? onPressed,
  required Color buttonColor,
  required Color textColor,
  String?  imagePath,
  double? height,
  IconData?icon,
  double? width,
  EdgeInsetsGeometry? padding,
  bool showProgress = false,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      padding: padding ?? EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      minimumSize: Size(width ?? double.infinity, height ?? 50),
    ),
    child:  Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(icon!=null)...[
          Icon(icon, color: textColor,size: 20.sp,),
          horizontalSpacer(4),
        ],
        Text(
          label,
          style: TextStyle(fontSize: 16.sp, color: textColor),
        ),
      ],
    ),
  );
}