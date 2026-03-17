import 'package:prevalencias/models/models.dart';

/// In-memory repository for the active evaluation session.
///
/// Today: stores one active session in RAM.
/// Future migration path: swap this class body for a Hive/Supabase
/// implementation — callers (pages) won't need to change at all.
class EvaluationRepository {
  EvaluationRepository._();
  static final EvaluationRepository instance = EvaluationRepository._();

  EvaluationSession? _activeSession;

  /// Returns the currently active session, or null if none.
  EvaluationSession? get activeSession => _activeSession;

  /// Starts a new session. Replaces any existing active session.
  void startSession(Sede sede, ClinicalArea area, StaffMember staff) {
    _activeSession = EvaluationSession(sede: sede, area: area, staff: staff);
  }

  /// Saves a response for a question in the active session.
  /// [formIndex] — index of the FormCategory (0-based).
  /// [questionId] — the question's id string (e.g. '1.', '4.2').
  void saveResponse(int formIndex, String questionId, bool? value) {
    _activeSession?.responses['${formIndex}_$questionId'] = value;
  }

  /// Reads a response from the active session.
  bool? getResponse(int formIndex, String questionId) =>
      _activeSession?.responses['${formIndex}_$questionId'];

  /// Saves an observation note for a form in the active session.
  void saveObservation(int formIndex, String text) {
    _activeSession?.observations['$formIndex'] = text;
  }

  /// Reads an observation from the active session.
  String getObservation(int formIndex) =>
      _activeSession?.observations['$formIndex'] ?? '';

  /// Clears the active session.
  void clearSession() => _activeSession = null;
}
