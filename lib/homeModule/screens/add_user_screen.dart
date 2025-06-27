// ignore_for_file: deprecated_member_use, avoid_print
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:userlist/theme/theme_extension.dart';
import '../../commonWidgets/circular_loader.dart';
import '../../commonWidgets/custom_textfield_widget.dart';
import '../../navigation/navigators.dart';
import '../providers/home_provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => AddUserScreenState();
}

class AddUserScreenState extends State<AddUserScreen> {
  final LocalStorage storage = LocalStorage('USER_LIST');

  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);

  bool isLoading = false;
  bool isValid = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();

  validate() {
    if (fullNameController.text.isNotEmpty &&
        mobileNoController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(emailController.text)) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  saveUser() async {
    if (isValid) {
      setState(() {
        isLoading = true;
      });

      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.addUserLocally(
        fullNameController.text.trim(),
        emailController.text.trim(),
        mobileNoController.text.trim(),
      );

      await Future.delayed(const Duration(seconds: 5));
      pop();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    mobileNoController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    tS = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add User',
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: tS * 20,
              color: context.colors.brandColor,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(dW * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: dW * 0.02),
                        child: CustomTextFieldWithLabel(
                          label: 'Name',
                          hintText: 'Enter name',
                          controller: fullNameController,
                          borderColor: const Color(0xFFD9D9D9),
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            validate();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: dW * 0.05),
                        child: CustomTextFieldWithLabel(
                          label: 'Phone Number',
                          hintText: 'Enter phone number',
                          controller: mobileNoController,
                          inputType: TextInputType.number,
                          borderColor: const Color(0xFFD9D9D9),
                          maxLength: 10,
                          onChanged: (value) {
                            validate();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: dW * 0.05),
                        child: CustomTextFieldWithLabel(
                          label: 'Email',
                          hintText: 'Enter valid email',
                          controller: emailController,
                          borderColor: const Color(0xFFD9D9D9),
                          inputType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          onChanged: (value) {
                            validate();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isValid)
              GestureDetector(
                onTap: saveUser,
                child: Container(
                  alignment: Alignment.center,
                  width: dW,
                  margin: EdgeInsets.all(dW * 0.05),
                  padding: EdgeInsets.all(dW * 0.04),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: [
                        context.colors.gradientOne,
                        context.colors.gradientTwo,
                      ])),
                  child: isLoading
                      ? const CircularLoader(
                          color: Color(0XFFFFFFFF),
                        )
                      : Text(
                          'Save',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: tS * 16,
                            color: const Color(0XFFFFFFFF),
                          ),
                        ),
                ),
              ),
          ],
        ));
  }
}
