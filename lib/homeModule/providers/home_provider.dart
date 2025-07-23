import 'package:flutter/material.dart';
import '../../api.dart';
import '../../http_helper.dart';
import '../models/employee_model.dart';

class HomeProvider extends ChangeNotifier {
  List<Employee> _employees = [];
  List<Employee> get employees => [..._employees];

  getEmployees() async {
    try {
      final url = '${webApi['domain']}${endPoint['getEmployees']}';
      final response = await RemoteServices.httpRequest(
        method: 'GET',
        url: url,
      );

      if (response['success']) {
        List<Employee> fetchedElements = [];

        response['result'].forEach((e) {
          fetchedElements.add(Employee.jsonToEmployee(e));
        });
        _employees = fetchedElements;
      }
      notifyListeners();

      return response;
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to get employees',
      };
    }
  }
  // getEmployees() async {
  //   _employees = [
  //     Employee(
  //       id: 1,
  //       name: 'Alice Smith',
  //       joiningDate: DateTime(2016, 5, 20),
  //       isActive: true,
  //     ),
  //     Employee(
  //       id: 2,
  //       name: 'Bob Johnson',
  //       joiningDate: DateTime(2022, 3, 15),
  //       isActive: true,
  //     ),
  //     Employee(
  //       id: 3,
  //       name: 'Charlie Davis',
  //       joiningDate: DateTime(2015, 8, 10),
  //       isActive: false,
  //     ),
  //   ];
  //   notifyListeners();
  //   return {
  //     'success': true,
  //     'message': 'Loaded local employees',
  //   };
  // }
}
