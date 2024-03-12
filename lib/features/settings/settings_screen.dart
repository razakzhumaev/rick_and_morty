import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String email = '';
  String password = '';

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  Future<void> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      email = prefs.getString('email') ?? '';
      password = prefs.getString('password') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Настройки',
                  style: TextStyle(
                    fontSize: 20,
                    color: themeProvider.changeTextColor(),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        email,
                        style:
                            TextStyle(color: themeProvider.changeTextColor()),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () {
                  context.push(RouterConstants.edittingScreen);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(335.w, 40.h),
                  backgroundColor: themeProvider.changeContainerColor(),
                  side: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                child: const Text(
                  'Редактировать',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 31.h),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ВНЕШНИЙ ВИД',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Icon(
                    Icons.format_paint_rounded,
                    size: 30,
                    color: themeProvider.changeTextColor(),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Темная тема',
                        style: TextStyle(
                          color: themeProvider.changeTextColor(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<ThemeProvider>().changeTheme();
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: themeProvider.changeTextColor(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36.h),
              const Divider(),
              SizedBox(height: 36.h),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'О ПРИЛОЖЕНИИ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.',
                style: TextStyle(
                  color: themeProvider.changeTextColor(),
                ),
              ),
              SizedBox(height: 36.h),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ВЕРСИЯ ПРИЛОЖЕНИЯ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rick & Morty v1.0.0',
                  style: TextStyle(
                    color: themeProvider.changeTextColor(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
