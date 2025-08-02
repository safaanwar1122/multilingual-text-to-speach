import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextFormField({
  required TextEditingController controller,
  required String label,

  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: TextInputType.multiline,
    textInputAction: TextInputAction.newline,
    maxLines: null,
    minLines: 1,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
    ),
  );
}
