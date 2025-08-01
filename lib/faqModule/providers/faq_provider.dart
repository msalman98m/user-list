import 'package:flutter/material.dart';
import '../../api.dart';
import '../../http_helper.dart';
import '../models/user_model.dart';

class FaqProvider extends ChangeNotifier {
  List<Faq> _faqs = [];
  List<Faq> get faqs => [..._faqs];

  fetchFaq() async {
    try {
      final url = '${webApi['domain']}${endPoint['fetchFaqs']}';
      final response = await RemoteServices.httpRequest(
        method: 'POST',
        url: url,
      );

      if (response['success']) {
        List<Faq> fetchedFaqs = [];

        response['result'].forEach((faq) {
          fetchedFaqs.add(Faq.jsonToFaq(faq));
        });
        _faqs = fetchedFaqs;
        notifyListeners();
      }
      return response;
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to get faqs',
      };
    }
  }

  addFaqLocally(String question, String answer) {
    Faq newFaq = Faq(
      id: '0',
      question: question,
      answer: answer,
    );

    _faqs.insert(0, newFaq);
    notifyListeners();
  }
}
