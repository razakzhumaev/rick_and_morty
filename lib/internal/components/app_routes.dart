import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/features/authorization/auth_screen.dart';
import 'package:rick_morty_app/features/authorization/create_account_screen.dart';
import 'package:rick_morty_app/features/authorization/reset_password_screen.dart';
import 'package:rick_morty_app/features/authorization/splash/splash_screen.dart';
import 'package:rick_morty_app/features/authorization/splash/splash_screen2.dart';
import 'package:rick_morty_app/features/authorization/verify_email_screen.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/episodes/presentation/screens/episode_detail_screen.dart';
import 'package:rick_morty_app/features/locations/data/model/location_model.dart';
import 'package:rick_morty_app/features/locations/presentation/screens/location_detail_screen.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';
import 'package:rick_morty_app/features/persons/presentation/screens/person_detail_screen.dart';
import 'package:rick_morty_app/internal/components/bottom_navbar.dart';
import 'package:rick_morty_app/features/settings/editting_screen.dart';
import 'package:rick_morty_app/internal/helpers/firebase_stream.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const FirebaseStream();
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouterConstants.splash1,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: RouterConstants.splash2,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen2();
      },
    ),
    GoRoute(
      path: RouterConstants.auth,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: RouterConstants.resetPassword,
      builder: (BuildContext context, GoRouterState state) {
        return const ResetPasswordScreen();
      },
    ),
    GoRoute(
      path: RouterConstants.signUp,
      builder: (BuildContext context, GoRouterState state) {
        return const CreateAccountScreen();
      },
    ),
    GoRoute(
      path: RouterConstants.verifyEmail,
      builder: (BuildContext context, GoRouterState state) {
        return const VerifyEmailScreen();
      },
    ),
    GoRoute(
      path: RouterConstants.searchScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const SearchScreen();
      },
    ),
    GoRoute(
      path: RouterConstants.edittingScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const EdittingScreen();
      },
    ),
    GoRoute(
      path: RouterConstants.personDetailScreen,
      builder: (BuildContext context, GoRouterState state) {
        PersonModel? personModel;
        if (state.extra != null) {
          final Map<String, Object?> params =
              state.extra as Map<String, Object?>;

          personModel = params['personModel'] as PersonModel;
        }

        return PersonDetailScreen(personModel: personModel!);
      },
    ),
    GoRoute(
      path: RouterConstants.locationDetailScreen,
      builder: (BuildContext context, GoRouterState state) {
        LocationModel? locationModel;
        if (state.extra != null) {
          final Map<String, Object?> params =
              state.extra as Map<String, Object?>;
          locationModel = params['locationModel'] as LocationModel;
        }
        return LocationDetailScreen(locationModel: locationModel!);
      },
    ),
    GoRoute(
      path: RouterConstants.episodeDetailScreen,
      builder: (BuildContext context, GoRouterState state) {
        EpisodeModel? episodeModel;
        if (state.extra != null) {
          final Map<String, Object?> params =
              state.extra as Map<String, Object?>;

          episodeModel = params['episodeModel'] as EpisodeModel;
        }
        return EpisodeDetailScreen(episodeModel: episodeModel!);
      },
    ),
  ],
);

class RouterConstants {
  static String splash1 = 'splash1';
  static String splash2 = '/splash2';
  static String auth = '/auth';
  static String resetPassword = '/reset_password';
  static String signUp = '/signup';
  static String verifyEmail = '/verify_email';
  static String searchScreen = '/searchScreen';
  static String edittingScreen = '/edittingScreen';
  static String personDetailScreen = '/personDetailScreen';
  static String locationDetailScreen = '/locationDetailScreen';
  static String episodeDetailScreen = '/episodeDetailScreen';
}
