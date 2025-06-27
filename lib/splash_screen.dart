// ignore_for_file: use_build_context_synchronously, unused_local_variable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'navigation/navigators.dart';
import 'navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final LocalStorage storage = LocalStorage('USER_LIST');

  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);

  goToHomeScreen() {
    Future.delayed(const Duration(seconds: 2),
        () => pushAndRemoveUntil(NamedRoute.userScreen));
  }

  @override
  void initState() {
    super.initState();

    goToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Container(
        color: theme.brightness == Brightness.light
            ? const Color(0XFFFFFFFF)
            : const Color(0XFF000000),
        height: dH,
        width: dW,
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: dW * 0.75,
            height: dH * 0.25,
          ),
        ),
      ),
    );
  }
}
