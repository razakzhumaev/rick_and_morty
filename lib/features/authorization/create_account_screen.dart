import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/internal/components/text_helper.dart';
import 'package:rick_morty_app/internal/helpers/snack_bar.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController firstNamecontroller = TextEditingController();

  final TextEditingController lastNamecontroller = TextEditingController();

  final TextEditingController middleNamecontroller = TextEditingController();

  final TextEditingController loginController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();
    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется , повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку',
          true,
        );
        return;
      }
    }
    context.push(RouterConstants.verifyEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            right: 28.w,
            left: 28.w,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Создать аккаунт',
                  style: TextHelper.w700s34,
                ),
                SizedBox(height: 40.h),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Введите Email',
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  autocorrect: false,
                  controller: passwordTextInputController,
                  obscureText: isHiddenPassword,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
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
                SizedBox(height: 20.h),
                TextFormField(
                  autocorrect: false,
                  controller: passwordTextRepeatInputController,
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
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
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
                SizedBox(height: 40.h),
                SizedBox(height: 63.h),
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
                    onPressed: signUp,
                    child: const Text('Создать'),
                    //  () async {
                    //   if (firstNamecontroller.text.isEmpty ||
                    //       lastNamecontroller.text.isEmpty ||
                    //       loginController.text.isEmpty ||
                    //       passwordController.text.isEmpty) {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => AlertDialog(
                    //         title: Text('Ошибка'),
                    //         content: Text('Пожалуйста , заполните все поля'),
                    //         actions: [
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //             },
                    //             child: Text('OK'),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   } else {
                    //     SharedPreferences prefs =
                    //         await SharedPreferences.getInstance();
                    //     await prefs.setString(
                    //         'firstName', firstNamecontroller.text);
                    //     await prefs.setString(
                    //         'lastName', lastNamecontroller.text);
                    //     await prefs.setString(
                    //         'middleName', middleNamecontroller.text);
                    //     await prefs.setString('username', loginController.text);
                    //     await prefs.setString(
                    //         'password', passwordController.text);
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => SearchScreen(),
                    //       ),
                    //     );
                    //   }
                    // },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
