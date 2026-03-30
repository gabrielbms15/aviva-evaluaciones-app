import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prevalencias/models/models.dart';

/// Service layer for evaluation set lifecycle management via Supabase.
class EvaluacionService {
  EvaluacionService._();

  static final _db = Supabase.instance.client;

  /// Returns the id of the currently active period (activo=true).
  /// Throws if no active period is found.
  static Future<String> getActivePeriodoId() async {
    final response = await _db
        .from('periodos')
        .select('id')
        .eq('activo', true)
        .limit(1)
        .single();
    return response['id'].toString();
  }

  /// Finds or creates an `evaluation_set` for the given employee + period.
  ///
  /// If the insert fails due to the unique constraint `uq_set` (duplicate),
  /// it falls back to querying the existing row and returns it.
  static Future<EvaluationSet> findOrCreateSet({
    required String empleadoId,
    required String periodoId,
  }) async {
    // Try to find existing set first.
    final existing = await _db
        .from('evaluacion_set')
        .select()
        .eq('empleado_id', empleadoId)
        .eq('periodo_id', periodoId)
        .maybeSingle();

    if (existing != null) {
      return EvaluationSet.fromJson(existing);
    }

    // Not found: attempt insert.
    try {
      final inserted = await _db
          .from('evaluacion_set')
          .insert({
            'empleado_id': empleadoId,
            'periodo_id': periodoId,
            'estado': 'incompleto',
          })
          .select()
          .single();
      return EvaluationSet.fromJson(inserted);
    } catch (_) {
      // Insert failed (likely uq_set race condition). Re-query and return.
      final fallback = await _db
          .from('evaluacion_set')
          .select()
          .eq('empleado_id', empleadoId)
          .eq('periodo_id', periodoId)
          .single();
      return EvaluationSet.fromJson(fallback);
    }
  }

  /// Returns all `evaluaciones` for a given set_id, joining `perfiles`
  /// to resolve the evaluador's display name.
  static Future<List<EvaluacionRecord>> getEvaluaciones(String setId) async {
    final response = await _db
        .from('evaluaciones')
        .select('*, perfiles(nombre)')
        .eq('set_id', setId);

    return (response as List)
        .map((row) => EvaluacionRecord.fromJson(row))
        .toList();
  }
}
