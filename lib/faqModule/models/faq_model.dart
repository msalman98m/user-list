class Faq {
  final String id;
  final String question;
  final String answer;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
  });

  static Faq jsonToFaq(Map faq) => Faq(
        id: faq['_id'],
        question: faq['question'] ?? '',
        answer: faq['answer'] ?? '',
      );
}
