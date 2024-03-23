import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/generated/l10n.dart';
import 'package:rick_morty_app/internal/components/app_routes.dart';
import 'package:rick_morty_app/internal/components/theme_provider.dart';
import 'package:rick_morty_app/internal/helpers/firebase_options.dart';
import 'package:rick_morty_app/internal/helpers/localization/bloc/global_localization_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalLocalizationBloc globalBloc = GlobalLocalizationBloc();
  String? locale;

  @override
  void initState() {
    localeHelper();
    super.initState();
  }

  localeHelper() async {
    String locale = await getCurrentLocale();
    globalBloc.add(ChangeLocaleEvent(locale: locale));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalLocalizationBloc(),
      child: BlocConsumer<GlobalLocalizationBloc, GlobalLocalizationState>(
        listener: (context, state) {
          if (state is GlobalLocalizationLoadedState) {
            locale = state.locale;
          }
        },
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return ChangeNotifierProvider(
                create: (context) => ThemeProvider(),
                child: Builder(
                  builder: (context) {
                    return MaterialApp.router(
                      locale: Locale.fromSubtags(languageCode: locale ?? 'ru'),
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      debugShowCheckedModeBanner: false,
                      title: 'Flutter Demo',
                      theme: context.watch<ThemeProvider>().theme,
                      routerConfig: router,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
