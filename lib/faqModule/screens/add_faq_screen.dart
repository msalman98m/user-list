// ignore_for_file: deprecated_member_use, avoid_print
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:userlist/theme/theme_extension.dart';
import '../../commonWidgets/circular_loader.dart';
import '../../commonWidgets/custom_textfield_widget.dart';
import '../../commonWidgets/no_internet_widget.dart';
import '../../connectivity_service.dart';
import '../../navigation/navigators.dart';
import '../providers/faq_provider.dart';

class AddFaqScreen extends StatefulWidget {
  const AddFaqScreen({super.key});

  @override
  State<AddFaqScreen> createState() => AddFaqScreenState();
}

class AddFaqScreenState extends State<AddFaqScreen> {
  final LocalStorage storage = LocalStorage('FAQS');

  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);

  bool isLoading = false;
  bool isValid = false;
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  validate() {
    if (questionController.text.isNotEmpty &&
        answerController.text.isNotEmpty) {
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

      final homeProvider = Provider.of<FaqProvider>(context, listen: false);
      homeProvider.addFaqLocally(
        questionController.text.trim(),
        answerController.text.trim(),
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
    questionController.dispose();
    answerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    tS = MediaQuery.of(context).textScaleFactor;
    final connectivityService = Provider.of<ConnectivityService>(context);
    if (!connectivityService.isConnected) {
      return const Scaffold(
        body: NoInternetWidget(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add FAQ',
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
                          label: 'Question',
                          hintText: 'Enter question',
                          controller: questionController,
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
                          label: 'Answer',
                          hintText: 'Enter answer',
                          controller: answerController,
                          borderColor: const Color(0xFFD9D9D9),
                          textCapitalization: TextCapitalization.sentences,
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
