class Sede {
  final String id;
  final String name;
  final String imagePath;

  const Sede({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  factory Sede.fromJson(Map<String, dynamic> json) => Sede(
        id: json['id'] as String,
        name: json['name'] as String,
        imagePath: json['imagePath'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imagePath': imagePath,
      };
}

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
  final String sedeId;
  final String areaId;
  final String role;

  const StaffMember({
    required this.id,
    required this.name,
    required this.sedeId,
    required this.areaId,
    required this.role,
  });

  // Keep 'unit' as a getter for backward compatibility with main.dart
  String get unit => areaId;

  factory StaffMember.fromJson(Map<String, dynamic> json) => StaffMember(
        id: json['id'] as String,
        name: json['name'] as String,
        sedeId: json['sedeId'] as String,
        areaId: json['areaId'] as String,
        role: json['role'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sedeId': sedeId,
        'areaId': areaId,
        'role': role,
      };
}

class FormCategory {
  final String id;
  final String title;
  final List<Question> questions;

  const FormCategory({required this.id, required this.title, required this.questions});
}

/// Represents a single evaluation session for one staff member in one area.
///
/// Key format: eval_{sedeId}_{areaId}_{staffId}_{date}
class EvaluationSession {
  final Sede sede;
  final ClinicalArea area;
  final StaffMember staff;
  final DateTime startedAt;

  /// Responses keyed by: '{formIndex}_{questionId}' → 'SI' | 'NO' | 'NO_APLICA' | null
  final Map<String, String?> responses;

  /// Observations keyed by formIndex as string
  final Map<String, String> observations;

  EvaluationSession({
    required this.sede,
    required this.area,
    required this.staff,
    DateTime? startedAt,
    Map<String, String?>? responses,
    Map<String, String>? observations,
  })  : startedAt = startedAt ?? DateTime.now(),
        responses = responses ?? {},
        observations = observations ?? {};

  /// Unique, collision-safe key for persistence.
  String get sessionKey {
    final date = startedAt.toIso8601String().substring(0, 10);
    return 'eval_${sede.id}_${area.id}_${staff.id}_$date';
  }
}

class EvaluationSet {
  final String id;
  final String empleadoId;
  final String periodoId;
  final String estado;

  const EvaluationSet({
    required this.id,
    required this.empleadoId,
    required this.periodoId,
    required this.estado,
  });

  factory EvaluationSet.fromJson(Map<String, dynamic> json) => EvaluationSet(
        id: json['id'].toString(),
        empleadoId: json['empleado_id'].toString(),
        periodoId: json['periodo_id'].toString(),
        estado: json['estado']?.toString() ?? 'incompleto',
      );
}

class EvaluacionRecord {
  final String id;
  final String setId;
  final String formularioId;
  final String? evaluadorId;
  final String? evaluadorNombre;
  final String estado;

  const EvaluacionRecord({
    required this.id,
    required this.setId,
    required this.formularioId,
    this.evaluadorId,
    this.evaluadorNombre,
    required this.estado,
  });

  factory EvaluacionRecord.fromJson(Map<String, dynamic> json) => EvaluacionRecord(
        id: json['id'].toString(),
        setId: json['set_id'].toString(),
        formularioId: json['formulario_id'].toString(),
        evaluadorId: json['evaluador_id']?.toString(),
        evaluadorNombre: json['perfiles'] != null
            ? json['perfiles']['nombre']?.toString()
            : null,
        estado: json['estado']?.toString() ?? 'pendiente',
      );
}
