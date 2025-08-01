import 'package:equatable/equatable.dart';

// Events
abstract class FaqEvent extends Equatable {
  const FaqEvent();

  @override
  List<Object> get props => [];
}

class FetchFaqs extends FaqEvent {}

class AddFaqLocally extends FaqEvent {
  final String question;
  final String answer;

  const AddFaqLocally({required this.question, required this.answer});

  @override
  List<Object> get props => [question, answer];
}
