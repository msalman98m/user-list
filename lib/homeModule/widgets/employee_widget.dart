// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:userlist/theme/theme_extension.dart';
import '../models/employee_model.dart';

class EmployeeWidget extends StatefulWidget {
  final Employee employee;
  const EmployeeWidget({
    super.key,
    required this.employee,
  });

  @override
  State<EmployeeWidget> createState() => EmployeeWidgetState();
}

class EmployeeWidgetState extends State<EmployeeWidget> {
  double dW = 0.0;
  double dH = 0.0;
  double tS = 0.0;
  ThemeData get theme => Theme.of(context);

  bool get activeEmployee {
    final isActive = widget.employee.isActive;
    final now = DateTime.now();
    final joiningDate = widget.employee.joiningDate;
    final fiveYearsAgo = now.subtract(const Duration(days: 5 * 365));
    return isActive && joiningDate.isBefore(fiveYearsAgo);
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    tS = MediaQuery.of(context).textScaleFactor;
    return Container(
      margin:
          EdgeInsets.only(left: dW * 0.05, right: dW * 0.05, bottom: dW * 0.05),
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
          children: [
            Expanded(
              child: Text(
                widget.employee.name,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: tS * 12,
                  color: context.colors.subheading,
                ),
              ),
            ),
            if (activeEmployee)
              Icon(
                Icons.verified,
                color: Colors.green,
                size: tS * 21,
              ),
          ],
        ),
      ),
    );
  }
}
