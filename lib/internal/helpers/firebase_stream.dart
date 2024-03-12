import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/features/authorization/auth_screen.dart';
import 'package:rick_morty_app/features/authorization/verify_email_screen.dart';

class FirebaseStream extends StatefulWidget {
  const FirebaseStream({super.key});

  @override
  State<FirebaseStream> createState() => _FirebaseStreamState();
}

class _FirebaseStreamState extends State<FirebaseStream> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      context.go('/${RouterConstants.splash1}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Что-то пошло не так !'),
              ),
            );
          } else if (snapshot.hasData) {
            if (!snapshot.data!.emailVerified) {
              return const VerifyEmailScreen();
            }
            return const AuthScreen();
          } else {
            return const AuthScreen();
          }
        });
  }
}
