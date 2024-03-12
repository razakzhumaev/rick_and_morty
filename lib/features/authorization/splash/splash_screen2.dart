import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    Timer(const Duration(seconds: 2), () {
      if (user != null) {
        context.go(RouterConstants.searchScreen);
      } else {
        context.go(RouterConstants.auth);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash2.png',
        height: 1.sh,
        width: 1.sw,
        fit: BoxFit.cover,
      ),
    );
  }
}
