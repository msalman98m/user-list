// ignore_for_file: use_build_context_synchronously, unused_local_variable, deprecated_member_use
import 'package:employeelist/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '../../commonWidgets/asset_svg_icon.dart';
import '../../commonWidgets/circular_loader.dart';
import '../../commonWidgets/custom_textfield_widget.dart';
import '../../commonWidgets/no_internet_widget.dart';
import '../../connectivity_service.dart';
import '../../theme/theme_manager.dart';
import '../models/employee_model.dart';
import '../providers/home_provider.dart';
import '../widgets/employee_widget.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  EmployeeScreenState createState() => EmployeeScreenState();
}

class EmployeeScreenState extends State<EmployeeScreen> {
  final LocalStorage storage = LocalStorage('EMPLOYEE_LIST');

  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);
  bool isLoading = false;
  List<Employee> employees = [];
  TextEditingController searchController = TextEditingController();
  late FocusNode _searchFocusNode;
  List searchedEmployees = [];

  getEmployees() async {
    setState(() {
      isLoading = true;
    });

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final response = await homeProvider.getEmployees();

    setState(() {
      isLoading = false;
    });

    if (response['success']) {
      employees = homeProvider.employees;
      searchedEmployees = employees;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    getEmployees();
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
    employees = Provider.of<HomeProvider>(context).employees;
    final connectivityService = Provider.of<ConnectivityService>(context);
    final switchTheme = Provider.of<ThemeNotifier>(context);

    if (searchedEmployees.length != employees.length &&
        searchController.text.isEmpty) {
      searchedEmployees = employees;
    }

    if (!connectivityService.isConnected) {
      return const Scaffold(
        body: NoInternetWidget(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employees',
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
              hintText: 'Search Employee',
              inputType: TextInputType.name,
              borderColor: const Color(0xFFD9D9D9),
              onChanged: (value) {
                setState(() {
                  searchedEmployees = employees.where((e) {
                    final name = e.name.toString().toLowerCase();
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
                    searchedEmployees = employees;
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
              : searchedEmployees.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: dW * 0.2),
                      alignment: Alignment.center,
                      child: Text(
                        'No employees found!',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: tS * 12,
                          color: context.colors.subheading,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchedEmployees.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) => EmployeeWidget(
                          employee: searchedEmployees[i],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
