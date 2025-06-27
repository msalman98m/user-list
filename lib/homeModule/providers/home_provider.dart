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

  addUserLocally(String name, String email, String phone) {
    User newUser = User(
      id: 0,
      name: name,
      email: email,
      phone: phone,
      username: '',
      website: '',
      address: Address(
        street: '',
        suite: '',
        city: '',
        zipcode: '',
        geo: Geo(lat: '', lng: ''),
      ),
      company: Company(
        name: '',
        catchPhrase: '',
        bs: '',
      ),
    );

    _users.insert(0, newUser);
    notifyListeners();
  }
}
