import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextFormField({
  required TextEditingController controller,
  required String label,
Widget? suffixIcon,
  int minCharLimit=10,
  String charLimitHint = 'Character limit should be at least 10',
  required String? Function(String?)? validator,
}) {
  return ValueListenableBuilder(
    valueListenable: controller,
    builder: (context, value, child) {
      final isBelowLimit=value.text.trim().length<minCharLimit;
      return Column(
        children: [
          TextFormField(
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
           suffixIcon: suffixIcon,
            ),
          ),
          if(isBelowLimit)
            Padding( padding: EdgeInsets.only(top: 6.h, left: 4.w),
            child: Text(
              charLimitHint,
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 12.sp,
              ),
            ),
            
            ),
        ],
      );
    }
  );
}
