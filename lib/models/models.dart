class ClinicalArea {
  final String name;
  final String location;
  final String? logoUrl;

  ClinicalArea({
    required this.name,
    required this.location,
    this.logoUrl,
  });
}

class Question {
  final String id;
  final String text;
  final List<Question>? subQuestions;

  Question({required this.id, required this.text, this.subQuestions});
}

class StaffMember {
  final String name;
  final String unit;
  final String role;

  StaffMember({required this.name, required this.unit, required this.role});
}

class FormCategory {
  final String title;
  final List<Question> questions;

  FormCategory({required this.title, required this.questions});
}
