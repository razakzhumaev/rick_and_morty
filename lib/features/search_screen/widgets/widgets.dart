// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';

class RegistrationTextField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final BorderSide? borderSide;

  const RegistrationTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.borderSide,
  }) : super(key: key);

  @override
  State<RegistrationTextField> createState() => _RegistrationTextFieldState();
}

class _RegistrationTextFieldState extends State<RegistrationTextField> {
  final int maxLength = 10;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          widget.controller?.text = value;
        });
      },
      decoration: InputDecoration(
        counterText: '${maxLength - (widget.controller?.text.length ?? 0)}/10',
        prefixIcon: Icon(
          widget.prefixIcon,
          color: Colors.grey,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final ThemeProvider themeProvider;
  final String hintText;
  final Widget? suffixIcon;
  final ValueChanged<String> onChanged;

  const SearchTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    required this.onChanged,
    required this.themeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(

        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w300,
          color: themeProvider.changeTextColor()
        ),
        filled: true,
        fillColor: themeProvider.changeTextFieldColor(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class TextFieldSnp extends StatelessWidget {
  final ThemeProvider themeProvider;
  final String hintText;

  const TextFieldSnp({
    Key? key,
    required this.themeProvider,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: themeProvider.changeTextFieldColor(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

abstract class TextHelper {
  static TextStyle w500s16white = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static TextStyle w400s12grey =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey);
  static TextStyle w500s10green = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}
