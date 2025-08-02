// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userlist/blocs/theme/theme_bloc.dart';
import 'package:userlist/blocs/theme/theme_state.dart';
import 'package:userlist/blocs/theme/theme_event.dart';
import 'package:userlist/blocs/faq/faq_bloc.dart';
import 'package:userlist/blocs/connectivity/connectivity_bloc.dart';
import 'package:userlist/theme/app_color.dart';

import 'navigation/navigation_service.dart';
import 'splash_screen.dart';

final LocalStorage storage = LocalStorage('FAQS');
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> awaitStorageReady() async {
  await storage.ready;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock device orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Fallback light theme with AppColors extension
  final fallbackLightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    extensions: const [AppColors.light],
    primaryColor: const Color(0XFF5B71FC),
    brightness: Brightness.light,
    fontFamily: 'Inter',
    cardColor: const Color(0xFFFFF9F4),
    scaffoldBackgroundColor: const Color(0xFFF6F6F6),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFFF6F6F6),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: Color(0XFF2D2D2D)),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: Color(0XFF2D2D2D)),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: Color(0XFF2D2D2D)),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()..add(LoadTheme())),
        BlocProvider(create: (_) => FaqBloc()),
        BlocProvider(create: (_) => ConnectivityBloc()),
      ],
      child: BlocSelector<ThemeBloc, ThemeState, ThemeData>(
        selector: (state) =>
            state is ThemeLoaded ? state.themeData : fallbackLightTheme,
        builder: (context, themeData) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            title: 'User List',
            theme: themeData,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: generateRoute,
            routes: {
              '/': (BuildContext context) => const SplashScreen(),
            },
          );
        },
      ),
    );
  }
}
