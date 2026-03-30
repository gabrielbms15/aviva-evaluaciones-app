import 'package:prevalencias/models/models.dart';

/// In-memory repository for the active evaluation session.
class EvaluationRepository {
  EvaluationRepository._();
  static final EvaluationRepository instance = EvaluationRepository._();

  EvaluationSession? _activeSession;

  /// ID of the active `evaluation_set` row in Supabase.
  String? activeSetId;

  /// Records from `evaluaciones` for the active set (populated on session start).
  List<EvaluacionRecord> evaluaciones = [];

  /// Returns the currently active session, or null if none.
  EvaluationSession? get activeSession => _activeSession;

  /// Starts a new session. Replaces any existing active session.
  void startSession(Sede sede, ClinicalArea area, StaffMember staff) {
    _activeSession = EvaluationSession(sede: sede, area: area, staff: staff);
  }

  /// Saves a response ('SI', 'NO', 'NO_APLICA', or null) for a question.
  /// [formIndex] — index of the FormCategory (0-based).
  /// [questionId] — the question's uuid from Supabase.
  void saveResponse(int formIndex, String questionId, String? value) {
    _activeSession?.responses['${formIndex}_$questionId'] = value;
  }

  /// Reads a response from the active session.
  String? getResponse(int formIndex, String questionId) =>
      _activeSession?.responses['${formIndex}_$questionId'];

  /// Saves an observation note for a form in the active session.
  void saveObservation(int formIndex, String text) {
    _activeSession?.observations['$formIndex'] = text;
  }

  /// Reads an observation from the active session.
  String getObservation(int formIndex) =>
      _activeSession?.observations['$formIndex'] ?? '';

  /// Clears the active session and evaluation set state.
  void clearSession() {
    _activeSession = null;
    activeSetId = null;
    evaluaciones = [];
  }
}


