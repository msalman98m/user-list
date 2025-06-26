// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:userlist/theme/theme_extension.dart';
import '../../commonWidgets/no_internet_widget.dart';
import '../../connectivity_service.dart';
import '../../navigation/arguments.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserDetailsScreenArguments args;
  const UserDetailsScreen({super.key, required this.args});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final LocalStorage storage = LocalStorage('USER_LIST');

  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;

    final connectivityService = Provider.of<ConnectivityService>(context);
    if (!connectivityService.isConnected) {
      return const Scaffold(
        body: NoInternetWidget(),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(dW * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.colors.gradientOne,
                context.colors.gradientTwo,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            margin: EdgeInsets.all(dW * 0.0025),
            padding: EdgeInsets.all(dW * 0.05),
            decoration: BoxDecoration(
              color: context.colors.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
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
                        widget.args.user.name,
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
                          widget.args.user.phone,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: tS * 12,
                            color: context.colors.subheading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: dW * 0.05),
                  height: 1,
                  width: dW,
                  color: const Color(0XFFBBBBBB),
                ),
                Row(
                  children: [
                    Text(
                      'Username:',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: tS * 14,
                        color: context.colors.heading,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: dW * 0.02),
                      child: Text(
                        widget.args.user.username,
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
                        'Email:',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: tS * 14,
                          color: context.colors.heading,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: dW * 0.02),
                        child: Text(
                          widget.args.user.email,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: tS * 12,
                            color: context.colors.subheading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: dW * 0.025),
                  child: Row(
                    children: [
                      Text(
                        'Website:',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: tS * 14,
                          color: context.colors.heading,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: dW * 0.02),
                        child: Text(
                          widget.args.user.website,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: tS * 12,
                            color: context.colors.subheading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: dW * 0.025),
                  child: Row(
                    children: [
                      Text(
                        'Company Name:',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: tS * 14,
                          color: context.colors.heading,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: dW * 0.02),
                        child: Text(
                          widget.args.user.company.name,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: tS * 12,
                            color: context.colors.subheading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: dW * 0.025),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address:',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: tS * 14,
                          color: context.colors.heading,
                        ),
                      ),
                      SizedBox(width: dW * 0.02),
                      Flexible(
                        child: Text(
                          '${widget.args.user.address.suite}, ${widget.args.user.address.street}, ${widget.args.user.address.city}, ${widget.args.user.address.zipcode}',
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
          ),
        ),
      ),
    );
  }
}
