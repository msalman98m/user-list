// ignore_for_file: use_build_context_synchronously, unused_local_variable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:userlist/theme/theme_extension.dart';
import '../../commonWidgets/asset_svg_icon.dart';
import '../../commonWidgets/circular_loader.dart';
import '../../commonWidgets/custom_textfield_widget.dart';
import '../../commonWidgets/no_internet_widget.dart';
import '../../connectivity_service.dart';
import '../../navigation/navigators.dart';
import '../../navigation/routes.dart';
import '../../theme/theme_manager.dart';
import '../models/user_model.dart';
import '../providers/faq_provider.dart';
import '../widgets/faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  FaqScreenState createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {
  final LocalStorage storage = LocalStorage('FAQS');

  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);
  bool isLoading = false;
  List<Faq> faqs = [];
  TextEditingController searchController = TextEditingController();
  late FocusNode _searchFocusNode;
  List searchedFaqs = [];

  getUsers() async {
    setState(() {
      isLoading = true;
    });

    final homeProvider = Provider.of<FaqProvider>(context, listen: false);
    final response = await homeProvider.fetchFaq();

    setState(() {
      isLoading = false;
    });

    if (response is List) {
      faqs = homeProvider.faqs;
      searchedFaqs = faqs;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    tS = MediaQuery.of(context).textScaleFactor;
    faqs = Provider.of<FaqProvider>(context).faqs;
    final connectivityService = Provider.of<ConnectivityService>(context);
    final switchTheme = Provider.of<ThemeNotifier>(context);

    if (searchedFaqs.length != faqs.length && searchController.text.isEmpty) {
      searchedFaqs = faqs;
    }

    if (!connectivityService.isConnected) {
      return const Scaffold(
        body: NoInternetWidget(),
      );
    }

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          push(NamedRoute.addFaqScreen);
        },
        child: Container(
          padding: EdgeInsets.all(dW * 0.03),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              context.colors.gradientOne,
              context.colors.gradientTwo,
            ]),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.add,
                color: Color(0xFFFFFFFF),
                size: 19,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: dW * 0.015,
                  right: dW * 0.01,
                ),
                child: Text(
                  'FAQ',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: tS * 14,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: tS * 20,
            color: context.colors.brandColor,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: dW * 0.05),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (theme.brightness == Brightness.light) {
                      switchTheme.setDarkMode();
                    } else {
                      switchTheme.setLightMode();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(dW * 0.01),
                    decoration: BoxDecoration(
                      color: context.colors.cardBackground.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: context.colors.brandColor, width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(dW * 0.015),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.light
                                ? context.colors.brandColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: theme.brightness == Brightness.dark
                              ? Text(
                                  'Light',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: tS * 12,
                                  ),
                                )
                              : Container(
                                  height: dW * 0.05,
                                  width: dW * 0.05,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                ),
                        ),
                        SizedBox(width: dW * 0.02),
                        Container(
                          padding: EdgeInsets.all(dW * 0.015),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark
                                ? context.colors.brandColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: theme.brightness == Brightness.light
                              ? Text(
                                  'Dark',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: tS * 12,
                                  ),
                                )
                              : Container(
                                  height: dW * 0.05,
                                  width: dW * 0.05,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(dW * 0.05),
            child: CustomTextFieldWithLabel(
              textColor: const Color(0XFFFFFFFF),
              focusNode: _searchFocusNode,
              hintText: 'Search',
              inputType: TextInputType.name,
              borderColor: const Color(0xFFD9D9D9),
              onChanged: (value) {
                setState(() {
                  searchedFaqs = faqs.where((faq) {
                    final name = faq.question.toString().toLowerCase();
                    final query = value.toLowerCase();
                    return name.contains(query);
                  }).toList();
                });
              },
              suffixIconConstraints: const BoxConstraints(),
              suffixIcon: IconButton(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _searchFocusNode.unfocus();
                    searchController.clear();
                    searchedFaqs = faqs;
                  });
                },
                icon: searchController.text.isEmpty
                    ? const SizedBox.shrink()
                    : const Icon(
                        Icons.clear,
                        color: Color(0XFFFFFFFF),
                        size: 23,
                      ),
              ),
              controller: searchController,
              prefixIcon: SizedBox(
                width: dW * 0.15,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: dW * 0.05),
                      color: Colors.transparent,
                      child: AssetSvgIcon(
                        'search',
                        width: dW * 0.06,
                        gradient: LinearGradient(
                          colors: [
                            context.colors.gradientOne,
                            context.colors.gradientTwo,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  padding: EdgeInsets.only(top: dW * 0.2),
                  child: const CircularLoader(),
                )
              : searchedFaqs.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: dW * 0.2),
                      alignment: Alignment.center,
                      child: Text(
                        'No faqs found!',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: tS * 12,
                          color: context.colors.subheading,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            bottom: dW * 0.05,
                            left: dW * 0.04,
                            right: dW * 0.04),
                        itemCount: searchedFaqs.length,
                        itemBuilder: (context, index) {
                          final faq = faqs[index];
                          return FaqWidget(
                              question: faq.question, answer: faq.answer);
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
