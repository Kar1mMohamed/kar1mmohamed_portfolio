import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textField({
  double? padding,
  Widget? icon,
  TextEditingController? controller,
  String? hint,
  bool? isPassword,
  TextAlign? textAlign,
  List<TextInputFormatter>? inputFormatters,
  Function(String)? onSubmitted,
  void Function(String)? onChanged,
}) =>
    Container(
      padding: EdgeInsets.all(padding ?? 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        // color: Colors.white,
      ),
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        obscureText: isPassword ?? false,
        controller: controller,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          icon: icon,
          label: Text(
            hint ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
      ),
    );

Widget textFormField({
  double? padding,
  Widget? icon,
  TextEditingController? controller,
  String? hint,
  bool? isPassword,
  bool isEmail = false,
  bool expands = false,
  TextAlign? textAlign,
  bool readOnly = false,
  List<TextInputFormatter>? inputFormatters,
  void Function(String)? onChanged,
}) =>
    Container(
      padding: EdgeInsets.all(padding ?? 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        // color: Colors.white, // mirgrate to material3 theme
      ),
      child: TextFormField(
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        obscureText: isPassword ?? false,
        obscuringCharacter: '•',
        controller: controller,
        expands: expands,
        minLines: null,
        maxLines: isPassword ?? false ? 1 : null,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          fontFamily: 'MyFont',
          color: Colors.white,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          icon: icon,
          label: Text(
            hint ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        validator: (string) {
          if (string!.isEmpty) {
            return 'Please enter your data correctly';
          }
          if (string.length < 3) {
            return 'Please enter your data correctly';
          }
          if (isEmail && !string.contains('@')) {
            return 'Please enter your data correctly';
          }
          return null;
        },
      ),
    );
