import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';
import 'package:rick_morty_app/internal/helpers/localization/bloc/global_localization_bloc.dart';

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
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final ThemeProvider themeProvider;
  final String hintText;
  final ValueChanged<String> onChanged;

  const SearchTextField({
    Key? key,
    required this.hintText,
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
        suffixIcon: Column(
          children: [
            InkWell(
              onTap: () => context.read<GlobalLocalizationBloc>().add(
                    ChangeLocaleEvent(locale: 'en'),
                  ),
              child: const Icon(Icons.language),
            ),
            InkWell(
              onTap: () => context.read<GlobalLocalizationBloc>().add(
                    ChangeLocaleEvent(locale: 'ru'),
                  ),
              child: const Icon(Icons.language),
            ),
          ],
        ),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            color: themeProvider.changeTextColor()),
        filled: true,
        fillColor: themeProvider.changeTextFieldColor(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
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
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
