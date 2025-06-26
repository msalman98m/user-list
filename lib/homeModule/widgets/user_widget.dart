// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:userlist/theme/theme_extension.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigators.dart';
import '../../navigation/routes.dart';
import '../models/user_model.dart';

class UserWidget extends StatefulWidget {
  final User user;
  const UserWidget({
    super.key,
    required this.user,
  });

  @override
  State<UserWidget> createState() => UserWidgetState();
}

class UserWidgetState extends State<UserWidget> {
  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    tS = MediaQuery.of(context).textScaleFactor;
    return GestureDetector(
      onTap: () {
        push(
          NamedRoute.userDetailsScreen,
          arguments: UserDetailsScreenArguments(
            user: widget.user,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
            left: dW * 0.05, right: dW * 0.05, bottom: dW * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              context.colors.gradientOne,
              context.colors.gradientTwo,
            ],
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(dW * 0.0025),
          padding: EdgeInsets.all(dW * 0.05),
          decoration: BoxDecoration(
            color: context.colors.cardBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name:',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: tS * 14,
                          color: context.colors.heading,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: dW * 0.02),
                        child: Text(
                          widget.user.name,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: tS * 12,
                            color: context.colors.subheading,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: dW * 0.025),
                    child: Row(
                      children: [
                        Text(
                          'Phone:',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: tS * 14,
                            color: context.colors.heading,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: dW * 0.02),
                          child: Text(
                            widget.user.phone,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: tS * 12,
                              color: context.colors.subheading,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
