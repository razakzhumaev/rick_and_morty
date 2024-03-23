import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/generated/l10n.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';
import 'package:rick_morty_app/internal/helpers/localization/bloc/global_localization_bloc.dart';
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
                  S.of(context).settings,
                  style: TextStyle(
                    fontSize: 20.sp,
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
                      Text(
                        password,
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
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  minimumSize: Size(
                    335.w,
                    40.h,
                  ),
                  backgroundColor: themeProvider.changeContainerColor(),
                  side: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                child: Text(
                  S.of(context).edit,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 31.h),
              const Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).appearance,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Icon(
                    Icons.format_paint_rounded,
                    size: 30.r,
                    color: themeProvider.changeTextColor(),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    S.of(context).dartMode,
                    style: TextStyle(
                      color: themeProvider.changeTextColor(),
                    ),
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
                      size: 15.r,
                      color: themeProvider.changeTextColor(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  InkWell(  
                    onTap: () {
                      context
                          .read<GlobalLocalizationBloc>()
                          .add(ChangeLocaleEvent(locale: 'en'));
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.language,
                          color: themeProvider.changeTextColor(),
                        ),
                        Text(
                          'ENGLISH',
                          style:
                              TextStyle(color: themeProvider.changeTextColor()),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      context
                          .read<GlobalLocalizationBloc>()
                          .add(ChangeLocaleEvent(locale: 'ru'));
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.language,
                          color: themeProvider.changeTextColor(),
                        ),
                        Text(
                          'RUSSIAN',
                          style:
                              TextStyle(color: themeProvider.changeTextColor()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              const Divider(),
              SizedBox(height: 36.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).aboutTheApp,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                S.of(context).zigerios,
                style: TextStyle(
                  color: themeProvider.changeTextColor(),
                ),
              ),
              SizedBox(height: 36.h),
              const Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).appVersion,
                  style: const TextStyle(
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
