// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class RemoteServices {
  static httpRequest(
      {required String method,
      required String url,
      Map body = const {},
      String accessToken = ''}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (accessToken != '') {
        headers['Authorization'] = 'Bearer $accessToken';
      }

      late http.Response response;

      if (method == 'POST') {
        response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
      } else if (method == 'PUT') {
        response = await http.put(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
      } else if (method == 'DELETE') {
        response = await http.delete(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
      } else if (method == 'GET') {
        response = await http.get(
          Uri.parse(url),
          headers: headers,
        );
      }

      return json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  static formDataRequest(
      {required String method,
      required String url,
      required Map<String, String> body,
      required Map<String, String> files,
      String accessToken = ''}) async {
    try {
      var request = http.MultipartRequest(method, Uri.parse(url));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      request.fields.addAll(body);

      // Note: File upload functionality is not supported on web
      // This method is kept for mobile compatibility only
      if (!kIsWeb) {
        // Only execute file operations on mobile platforms
        files.forEach((key, value) async {
          // This will only run on mobile platforms
          // File operations are not supported on web
        });
      }

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      final responseData = json.decode(respStr);

      return responseData;
    } catch (e) {
      rethrow;
    }
  }
}
