// ignore_for_file: use_build_context_synchronously, unused_local_variable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userlist/theme/theme_extension.dart';
import '../../commonWidgets/asset_svg_icon.dart';
import '../../commonWidgets/circular_loader.dart';
import '../../commonWidgets/custom_textfield_widget.dart';
import '../../commonWidgets/no_internet_widget.dart';
import '../../blocs/connectivity/connectivity_bloc.dart';
import '../../blocs/connectivity/connectivity_state.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_state.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/faq/faq_bloc.dart';
import '../../blocs/faq/faq_state.dart';
import '../../blocs/faq/faq_event.dart';
import '../../navigation/navigators.dart';
import '../../navigation/routes.dart';
import '../../utils/responsive_utils.dart';
import '../models/faq_model.dart';
import '../widgets/faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  FaqScreenState createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {
  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);
  List<Faq> faqs = [];
  TextEditingController searchController = TextEditingController();
  late FocusNode _searchFocusNode;
  List searchedFaqs = [];

  getFaqs() async {
    context.read<FaqBloc>().add(FetchFaqs());
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    getFaqs();
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

    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, connectivityState) {
        if (connectivityState is ConnectivityDisconnected) {
          return const Scaffold(
            body: NoInternetWidget(),
          );
        }

        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final switchTheme = context.read<ThemeBloc>();

            return BlocBuilder<FaqBloc, FaqState>(
              builder: (context, faqState) {
                if (faqState is FaqLoaded) {
                  faqs = faqState.faqs;
                  if (searchedFaqs.length != faqs.length &&
                      searchController.text.isEmpty) {
                    searchedFaqs = faqs;
                  }
                }

                Widget scaffoldContent = Scaffold(
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
                                  switchTheme.add(SetDarkMode());
                                } else {
                                  switchTheme.add(SetLightMode());
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(dW * 0.01),
                                decoration: BoxDecoration(
                                  color: context.colors.cardBackground
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: context.colors.brandColor,
                                      width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(dW * 0.015),
                                      decoration: BoxDecoration(
                                        color:
                                            theme.brightness == Brightness.light
                                                ? context.colors.brandColor
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: theme.brightness == Brightness.dark
                                          ? Text(
                                              'Light',
                                              style: theme.textTheme.bodyMedium!
                                                  .copyWith(
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
                                        color:
                                            theme.brightness == Brightness.dark
                                                ? context.colors.brandColor
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: theme.brightness ==
                                              Brightness.light
                                          ? Text(
                                              'Dark',
                                              style: theme.textTheme.bodyMedium!
                                                  .copyWith(
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
                  body: SafeArea(
                    child: Column(
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
                                  final name =
                                      faq.question.toString().toLowerCase();
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
                        Expanded(
                          child: faqState is FaqLoading
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
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                          fontSize: tS * 12,
                                          color: context.colors.subheading,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                          bottom: dW * 0.05,
                                          left: dW * 0.04,
                                          right: dW * 0.04),
                                      itemCount: searchedFaqs.length,
                                      itemBuilder: (context, index) {
                                        final faq = searchedFaqs[index];
                                        return FaqWidget(
                                            question: faq.question,
                                            answer: faq.answer);
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                );

                return ResponsiveUtils.getResponsiveContainer(
                  context,
                  scaffoldContent,
                );
              },
            );
          },
        );
      },
    );
  }
}
