// ignore_for_file: use_build_context_synchronously, unused_local_variable
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
    final double dW = MediaQuery.of(context).size.width;
    final double dH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
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
