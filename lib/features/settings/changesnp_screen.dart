// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:rick_morty_app/features/search_screen/widgets/widgets.dart';

class ChangeSnpScreen extends StatelessWidget {
  final String email;
  final String password;
  const ChangeSnpScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить ФИО'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 61.h,
          right: 16.w,
          left: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('email'),
            SizedBox(height: 8.h),
            TextFieldSnp(
              themeProvider: Provider.of(context),
              hintText: email,
            ),
            SizedBox(height: 10.h),
            const Text('password'),
            SizedBox(height: 8.h),
            TextFieldSnp(
              themeProvider: Provider.of(context),
              hintText: password,
            ),
            SizedBox(height: 10.h),
            const Text('Отчество'),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
