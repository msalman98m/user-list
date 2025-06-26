import 'package:flutter/material.dart';
import '../../api.dart';
import '../../http_helper.dart';
import '../models/user_model.dart';

class HomeProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => [..._users];

  getUsers() async {
    try {
      final url = '${webApi['domain']}${endPoint['getUsers']}';
      final response = await RemoteServices.httpRequest(
        method: 'GET',
        url: url,
      );

      if (response is List) {
        List<User> fetchedElements = [];

        for (var e in response) {
          fetchedElements.add(User.jsonToUser(e));
        }
        _users = fetchedElements;
      }
      notifyListeners();

      return response;
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to get users',
      };
    }
  }
}
