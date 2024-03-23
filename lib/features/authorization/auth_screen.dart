import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/internal/components/text_helper.dart';
import 'package:rick_morty_app/internal/helpers/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('email', emailTextInputController.text.trim());
      prefs.setString('password', passwordTextInputController.text.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          'Неправильный email или пароль. Повторите попытку',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
        return;
      }
    }
    context.go(RouterConstants.searchScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 64.h),
              Row(
                children: [
                  SizedBox(width: 58.w),
                  Image.asset(
                    'assets/images/Group 2.png',
                    height: 376.h,
                    width: 267.w,
                  ),
                  SizedBox(width: 49.w),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 65.h,
                  left: 28.w,
                  right: 28.w,
                  bottom: 28.h,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Логин',
                        style: TextHelper.s14,
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: emailTextInputController,
                        validator: (email) {
                          email != null && !EmailValidator.validate(email)
                              ? 'Введите правильный Email'
                              : null;
                          return null;
                        },
                        style: const TextStyle(
                          decorationColor: Colors.green,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_2_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Email',
                          hintStyle: TextHelper.w300,
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Пароль',
                        style: TextHelper.s14,
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        autocorrect: false,
                        controller: passwordTextInputController,
                        obscureText: isHiddenPassword,
                        validator: (value) {
                          value != null && value.length < 6
                              ? 'Минимум 6 символов'
                              : null;
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: togglePasswordView,
                            child: Icon(
                              isHiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                          hintText: 'Пароль',
                          hintStyle: TextHelper.w300,
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: TextButton(
                          style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                          ),
                          onPressed: () {
                            context.push(RouterConstants.resetPassword);
                          },
                          child: const Text('Сбросить пароль'),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        height: 48.h,
                        width: 319.w,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.blue),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                          onPressed: login,
                          child: const Text('Войти'),
                        ),
                      ),
                      SizedBox(height: 28.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'У вас еще нет аккаунта?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: () {
                              context.push(RouterConstants.signUp);
                            },
                            child: const Text(
                              'Создать',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
