import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/internal/components/text_helper.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EdittingScreen extends StatefulWidget {
  const EdittingScreen({super.key});

  @override
  State<EdittingScreen> createState() => _EdittingScreenState();
}

class _EdittingScreenState extends State<EdittingScreen> {
  String email = '';
  String password = '';
  File? _imageFile;

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      email = prefs.getString('email') ?? '';
      password = prefs.getString('password') ?? '';
    });
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Редактировать профиль',
          style: TextStyle(
            color: themeProvider.changeTextColor(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 40.h,
              right: 16.w,
              left: 16.w,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      _selectImage();
                    },
                    child: Column(
                      children: [
                        _imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Image.file(
                                  _imageFile!,
                                  width: 200.w,
                                  height: 200.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Image.network(
                                  'https://elomsk.ru/uploads/images/shop/products/items/item_589065c6-44f8-11eb-a205-002590e40525.jpg',
                                  height: 200.h,
                                  width: 200.w,
                                ),
                              ),
                        Text(
                          'Изменить фото',
                          style: TextHelper.s16blue,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ПРОФИЛЬ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'email',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: themeProvider.changeTextColor(),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                email,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: themeProvider.changeTextColor(),
                      )
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Пароль',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: themeProvider.changeTextColor(),
                            ),
                          ),
                          Text(
                            password,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: themeProvider.changeTextColor(),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // logout();
                      signOut();
                      context.go(RouterConstants.auth);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      minimumSize: Size(
                        150.w,
                        50.h,
                      ),
                      backgroundColor: themeProvider.changeContainerColor(),
                      side: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    child: const Text(
                      'Выйти',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 200.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
