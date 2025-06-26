// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:userlist/theme/theme_extension.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 80,
            color: Colors.grey[400],
          ),
          Padding(
            padding: EdgeInsets.only(top: dW * 0.05),
            child: Text(
              'No Internet Connection',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: tS * 20,
                    color: context.colors.brandColor,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dW * 0.025),
            child: Text(
              'Please check your internet connection\nand try again',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: tS * 14,
                    color: context.colors.heading,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
