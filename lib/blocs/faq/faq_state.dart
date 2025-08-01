import 'package:equatable/equatable.dart';
import '../../faqModule/models/faq_model.dart';

// States
abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitial extends FaqState {}

class FaqLoading extends FaqState {}

class FaqLoaded extends FaqState {
  final List<Faq> faqs;

  const FaqLoaded(this.faqs);

  @override
  List<Object> get props => [faqs];
}

class FaqError extends FaqState {
  final String message;

  const FaqError(this.message);

  @override
  List<Object> get props => [message];
}
