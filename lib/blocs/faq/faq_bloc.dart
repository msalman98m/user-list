import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api.dart';
import '../../http_helper.dart';
import '../../faqModule/models/user_model.dart';
import 'faq_event.dart';
import 'faq_state.dart';

// BLoC
class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(FaqInitial()) {
    on<FetchFaqs>(_onFetchFaqs);
    on<AddFaqLocally>(_onAddFaqLocally);
  }

  Future<void> _onFetchFaqs(FetchFaqs event, Emitter<FaqState> emit) async {
    emit(FaqLoading());
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
        emit(FaqLoaded(fetchedFaqs));
      } else {
        emit(const FaqError('Failed to get faqs'));
      }
    } catch (e) {
      emit(const FaqError('Failed to get faqs'));
    }
  }

  void _onAddFaqLocally(AddFaqLocally event, Emitter<FaqState> emit) {
    if (state is FaqLoaded) {
      final currentState = state as FaqLoaded;
      Faq newFaq = Faq(
        id: '0',
        question: event.question,
        answer: event.answer,
      );

      List<Faq> updatedFaqs = [newFaq, ...currentState.faqs];
      emit(FaqLoaded(updatedFaqs));
    }
  }
}
