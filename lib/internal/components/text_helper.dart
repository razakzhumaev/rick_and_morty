import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextHelper {
  static TextStyle w500s16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle w400s12grey = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static TextStyle w500s10 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle w300 = const TextStyle(
    fontWeight: FontWeight.w300,
  );
  static TextStyle s14 = TextStyle(
    fontSize: 14.sp,
  );
  static TextStyle s20 = TextStyle(
    fontSize: 20.sp,
  );
  static TextStyle s16blue = TextStyle(
    fontSize: 16.sp,
    color: Colors.blue,
  );
  static TextStyle s16black = TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
  );

  static TextStyle w700s34 = TextStyle(
    fontSize: 34.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle w700s24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );
}
