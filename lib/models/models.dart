class ClinicalArea {
  final String id;
  final String name;
  final String location;
  final String? logoUrl;

  const ClinicalArea({
    required this.id,
    required this.name,
    required this.location,
    this.logoUrl,
  });

  factory ClinicalArea.fromJson(Map<String, dynamic> json) => ClinicalArea(
        id: json['id'] as String,
        name: json['name'] as String,
        location: json['location'] as String,
        logoUrl: json['logoUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        if (logoUrl != null) 'logoUrl': logoUrl,
      };
}

class Question {
  final String id;
  final String text;
  final List<Question>? subQuestions;

  const Question({required this.id, required this.text, this.subQuestions});
}

class StaffMember {
  final String id;
  final String name;
  final String areaId;
  final String role;

  const StaffMember({
    required this.id,
    required this.name,
    required this.areaId,
    required this.role,
  });

  // Keep 'unit' as a getter for backward compatibility with main.dart
  String get unit => areaId;

  factory StaffMember.fromJson(Map<String, dynamic> json) => StaffMember(
        id: json['id'] as String,
        name: json['name'] as String,
        areaId: json['areaId'] as String,
        role: json['role'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'areaId': areaId,
        'role': role,
      };
}

class FormCategory {
  final String title;
  final List<Question> questions;

  const FormCategory({required this.title, required this.questions});
}

/// Represents a single evaluation session for one staff member in one area.
///
/// Key format: eval_{areaId}_{staffId}_{date}
/// Example:    eval_cx_quir_staff_003_2026-03-13
class EvaluationSession {
  final ClinicalArea area;
  final StaffMember staff;
  final DateTime startedAt;

  /// Responses keyed by: '{formIndex}_{questionId}'
  final Map<String, bool?> responses;

  /// Observations keyed by formIndex as string
  final Map<String, String> observations;

  EvaluationSession({
    required this.area,
    required this.staff,
    DateTime? startedAt,
    Map<String, bool?>? responses,
    Map<String, String>? observations,
  })  : startedAt = startedAt ?? DateTime.now(),
        responses = responses ?? {},
        observations = observations ?? {};

  /// Unique, collision-safe key for persistence.
  String get sessionKey {
    final date = startedAt.toIso8601String().substring(0, 10);
    return 'eval_${area.id}_${staff.id}_$date';
  }
}
