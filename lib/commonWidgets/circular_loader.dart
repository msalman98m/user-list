import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CircularLoader extends StatelessWidget {
  final double android;
  final double iOS;
  final Color? color;

  const CircularLoader({
    super.key,
    this.android = 0.07,
    this.iOS = 12.0,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;

    // Use kIsWeb to detect platform instead of Platform.isIOS
    return kIsWeb || !kIsWeb
        ? Center(
            child: SizedBox(
              height: dW * android,
              width: dW * android,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                    color ?? Theme.of(context).primaryColor),
              ),
            ),
          )
        : CupertinoActivityIndicator(
            radius: iOS,
            color: color,
          );
  }
}

Widget circularForButton(double width,
    {Color color = Colors.white, double sW = 2.3}) {
  return Center(
    child: SizedBox(
      height: width,
      width: width,
      child: CircularProgressIndicator(
        strokeWidth: sW,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    ),
  );
}

Widget lazyLoader(double dW) {
  return Padding(
    padding: EdgeInsets.only(top: dW * 0.06, bottom: dW * 0.1),
    child: const Center(child: CircularLoader()),
  );
}
