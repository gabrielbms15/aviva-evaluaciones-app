import 'package:prevalencias/models/models.dart';

/// Listado oficial de UPSS del establecimiento.
const List<ClinicalArea> clinicalAreas = [
  ClinicalArea(id: 'cx_ext',   name: 'Consulta Externa',                          location: 'Piso 1, Torre A'),
  ClinicalArea(id: 'emerg',    name: 'Emergencia',                                  location: 'Piso 1, Torre B'),
  ClinicalArea(id: 'cx_obs',   name: 'Centro Obstétrico',                           location: 'Piso 2, Torre A'),
  ClinicalArea(id: 'cx_quir',  name: 'Centro Quirúrgico',                           location: 'Piso 2, Torre B'),
  ClinicalArea(id: 'hosp',     name: 'Hospitalización',                             location: 'Piso 3, Torre A'),
  ClinicalArea(id: 'uci',      name: 'Cuidados Intensivos',                         location: 'Piso 3, Torre B'),
  ClinicalArea(id: 'lab',      name: 'Patología Clínica (Laboratorio)',             location: 'Piso 1, Torre C'),
  ClinicalArea(id: 'anatomia', name: 'Anatomía Patológica',                         location: 'Piso 1, Torre D'),
  ClinicalArea(id: 'imagen',   name: 'Diagnóstico por Imágenes',                   location: 'Piso 2, Torre C'),
  ClinicalArea(id: 'rehab',    name: 'Medicina de Rehabilitación',                  location: 'Piso 2, Torre D'),
  ClinicalArea(id: 'nutricion',name: 'Nutrición y Dietética',                       location: 'Piso 3, Torre C'),
  ClinicalArea(id: 'hemot',    name: 'Centro de Hemoterapia y Banco de Sangre',    location: 'Piso 3, Torre D'),
  ClinicalArea(id: 'farmacia', name: 'Farmacia',                                    location: 'Piso 1, Torre E'),
  ClinicalArea(id: 'esteril',  name: 'Central de Esterilización',                  location: 'Piso 4, Torre A'),
];

/// Staff por área. IDs: {areaId}_s{N} — garantizan unicidad aunque los nombres sean iguales.
const Map<String, List<StaffMember>> staffByArea = {
  'cx_ext': [
    StaffMember(id: 'cx_ext_s1', name: 'Lorem Ipsum 1', areaId: 'cx_ext', role: 'Médico'),
    StaffMember(id: 'cx_ext_s2', name: 'Lorem Ipsum 2', areaId: 'cx_ext', role: 'Enfermera'),
    StaffMember(id: 'cx_ext_s3', name: 'Lorem Ipsum 3', areaId: 'cx_ext', role: 'Técnico'),
    StaffMember(id: 'cx_ext_s4', name: 'Lorem Ipsum 4', areaId: 'cx_ext', role: 'Auxiliar'),
    StaffMember(id: 'cx_ext_s5', name: 'Lorem Ipsum 5', areaId: 'cx_ext', role: 'Tecnólogo'),
  ],
  'emerg': [
    StaffMember(id: 'emerg_s1', name: 'Lorem Ipsum 1', areaId: 'emerg', role: 'Médico'),
    StaffMember(id: 'emerg_s2', name: 'Lorem Ipsum 2', areaId: 'emerg', role: 'Enfermera'),
    StaffMember(id: 'emerg_s3', name: 'Lorem Ipsum 3', areaId: 'emerg', role: 'Auxiliar'),
    StaffMember(id: 'emerg_s4', name: 'Lorem Ipsum 4', areaId: 'emerg', role: 'Técnico'),
    StaffMember(id: 'emerg_s5', name: 'Lorem Ipsum 5', areaId: 'emerg', role: 'Médico'),
  ],
  'cx_obs': [
    StaffMember(id: 'cx_obs_s1', name: 'Lorem Ipsum 1', areaId: 'cx_obs', role: 'Médico'),
    StaffMember(id: 'cx_obs_s2', name: 'Lorem Ipsum 2', areaId: 'cx_obs', role: 'Enfermera'),
    StaffMember(id: 'cx_obs_s3', name: 'Lorem Ipsum 3', areaId: 'cx_obs', role: 'Auxiliar'),
    StaffMember(id: 'cx_obs_s4', name: 'Lorem Ipsum 4', areaId: 'cx_obs', role: 'Técnico'),
    StaffMember(id: 'cx_obs_s5', name: 'Lorem Ipsum 5', areaId: 'cx_obs', role: 'Enfermera'),
  ],
  'cx_quir': [
    StaffMember(id: 'cx_quir_s1', name: 'Lorem Ipsum 1', areaId: 'cx_quir', role: 'Médico'),
    StaffMember(id: 'cx_quir_s2', name: 'Lorem Ipsum 2', areaId: 'cx_quir', role: 'Tecnólogo'),
    StaffMember(id: 'cx_quir_s3', name: 'Lorem Ipsum 3', areaId: 'cx_quir', role: 'Técnico'),
    StaffMember(id: 'cx_quir_s4', name: 'Lorem Ipsum 4', areaId: 'cx_quir', role: 'Enfermera'),
    StaffMember(id: 'cx_quir_s5', name: 'Lorem Ipsum 5', areaId: 'cx_quir', role: 'Auxiliar'),
  ],
  'hosp': [
    StaffMember(id: 'hosp_s1', name: 'Lorem Ipsum 1', areaId: 'hosp', role: 'Enfermera'),
    StaffMember(id: 'hosp_s2', name: 'Lorem Ipsum 2', areaId: 'hosp', role: 'Médico'),
    StaffMember(id: 'hosp_s3', name: 'Lorem Ipsum 3', areaId: 'hosp', role: 'Auxiliar'),
    StaffMember(id: 'hosp_s4', name: 'Lorem Ipsum 4', areaId: 'hosp', role: 'Técnico'),
    StaffMember(id: 'hosp_s5', name: 'Lorem Ipsum 5', areaId: 'hosp', role: 'Enfermera'),
  ],
  'uci': [
    StaffMember(id: 'uci_s1', name: 'Lorem Ipsum 1', areaId: 'uci', role: 'Médico'),
    StaffMember(id: 'uci_s2', name: 'Lorem Ipsum 2', areaId: 'uci', role: 'Enfermera'),
    StaffMember(id: 'uci_s3', name: 'Lorem Ipsum 3', areaId: 'uci', role: 'Técnico'),
    StaffMember(id: 'uci_s4', name: 'Lorem Ipsum 4', areaId: 'uci', role: 'Auxiliar'),
    StaffMember(id: 'uci_s5', name: 'Lorem Ipsum 5', areaId: 'uci', role: 'Tecnólogo'),
  ],
  'lab': [
    StaffMember(id: 'lab_s1', name: 'Lorem Ipsum 1', areaId: 'lab', role: 'Tecnólogo'),
    StaffMember(id: 'lab_s2', name: 'Lorem Ipsum 2', areaId: 'lab', role: 'Técnico'),
    StaffMember(id: 'lab_s3', name: 'Lorem Ipsum 3', areaId: 'lab', role: 'Auxiliar'),
    StaffMember(id: 'lab_s4', name: 'Lorem Ipsum 4', areaId: 'lab', role: 'Tecnólogo'),
    StaffMember(id: 'lab_s5', name: 'Lorem Ipsum 5', areaId: 'lab', role: 'Técnico'),
  ],
  'anatomia': [
    StaffMember(id: 'anatomia_s1', name: 'Lorem Ipsum 1', areaId: 'anatomia', role: 'Médico'),
    StaffMember(id: 'anatomia_s2', name: 'Lorem Ipsum 2', areaId: 'anatomia', role: 'Técnico'),
    StaffMember(id: 'anatomia_s3', name: 'Lorem Ipsum 3', areaId: 'anatomia', role: 'Auxiliar'),
    StaffMember(id: 'anatomia_s4', name: 'Lorem Ipsum 4', areaId: 'anatomia', role: 'Tecnólogo'),
    StaffMember(id: 'anatomia_s5', name: 'Lorem Ipsum 5', areaId: 'anatomia', role: 'Técnico'),
  ],
  'imagen': [
    StaffMember(id: 'imagen_s1', name: 'Lorem Ipsum 1', areaId: 'imagen', role: 'Tecnólogo'),
    StaffMember(id: 'imagen_s2', name: 'Lorem Ipsum 2', areaId: 'imagen', role: 'Técnico'),
    StaffMember(id: 'imagen_s3', name: 'Lorem Ipsum 3', areaId: 'imagen', role: 'Médico'),
    StaffMember(id: 'imagen_s4', name: 'Lorem Ipsum 4', areaId: 'imagen', role: 'Auxiliar'),
    StaffMember(id: 'imagen_s5', name: 'Lorem Ipsum 5', areaId: 'imagen', role: 'Tecnólogo'),
  ],
  'rehab': [
    StaffMember(id: 'rehab_s1', name: 'Lorem Ipsum 1', areaId: 'rehab', role: 'Médico'),
    StaffMember(id: 'rehab_s2', name: 'Lorem Ipsum 2', areaId: 'rehab', role: 'Tecnólogo'),
    StaffMember(id: 'rehab_s3', name: 'Lorem Ipsum 3', areaId: 'rehab', role: 'Auxiliar'),
    StaffMember(id: 'rehab_s4', name: 'Lorem Ipsum 4', areaId: 'rehab', role: 'Técnico'),
    StaffMember(id: 'rehab_s5', name: 'Lorem Ipsum 5', areaId: 'rehab', role: 'Enfermera'),
  ],
  'nutricion': [
    StaffMember(id: 'nutricion_s1', name: 'Lorem Ipsum 1', areaId: 'nutricion', role: 'Nutricionista'),
    StaffMember(id: 'nutricion_s2', name: 'Lorem Ipsum 2', areaId: 'nutricion', role: 'Nutricionista'),
    StaffMember(id: 'nutricion_s3', name: 'Lorem Ipsum 3', areaId: 'nutricion', role: 'Técnico'),
    StaffMember(id: 'nutricion_s4', name: 'Lorem Ipsum 4', areaId: 'nutricion', role: 'Auxiliar'),
    StaffMember(id: 'nutricion_s5', name: 'Lorem Ipsum 5', areaId: 'nutricion', role: 'Nutricionista'),
  ],
  'hemot': [
    StaffMember(id: 'hemot_s1', name: 'Lorem Ipsum 1', areaId: 'hemot', role: 'Médico'),
    StaffMember(id: 'hemot_s2', name: 'Lorem Ipsum 2', areaId: 'hemot', role: 'Tecnólogo'),
    StaffMember(id: 'hemot_s3', name: 'Lorem Ipsum 3', areaId: 'hemot', role: 'Técnico'),
    StaffMember(id: 'hemot_s4', name: 'Lorem Ipsum 4', areaId: 'hemot', role: 'Auxiliar'),
    StaffMember(id: 'hemot_s5', name: 'Lorem Ipsum 5', areaId: 'hemot', role: 'Tecnólogo'),
  ],
  'farmacia': [
    StaffMember(id: 'farmacia_s1', name: 'Lorem Ipsum 1', areaId: 'farmacia', role: 'Técnico'),
    StaffMember(id: 'farmacia_s2', name: 'Lorem Ipsum 2', areaId: 'farmacia', role: 'Auxiliar'),
    StaffMember(id: 'farmacia_s3', name: 'Lorem Ipsum 3', areaId: 'farmacia', role: 'Tecnólogo'),
    StaffMember(id: 'farmacia_s4', name: 'Lorem Ipsum 4', areaId: 'farmacia', role: 'Técnico'),
    StaffMember(id: 'farmacia_s5', name: 'Lorem Ipsum 5', areaId: 'farmacia', role: 'Auxiliar'),
  ],
  'esteril': [
    StaffMember(id: 'esteril_s1', name: 'Lorem Ipsum 1', areaId: 'esteril', role: 'Técnico'),
    StaffMember(id: 'esteril_s2', name: 'Lorem Ipsum 2', areaId: 'esteril', role: 'Auxiliar'),
    StaffMember(id: 'esteril_s3', name: 'Lorem Ipsum 3', areaId: 'esteril', role: 'Técnico'),
    StaffMember(id: 'esteril_s4', name: 'Lorem Ipsum 4', areaId: 'esteril', role: 'Auxiliar'),
    StaffMember(id: 'esteril_s5', name: 'Lorem Ipsum 5', areaId: 'esteril', role: 'Enfermera'),
  ],
};

/// Lista plana de todos los miembros del staff (para el dashboard).
final List<StaffMember> allStaffMembers =
    staffByArea.values.expand((list) => list).toList();

/// Retorna los miembros del staff para un área dada.
List<StaffMember> getStaffForArea(String areaId) =>
    staffByArea[areaId] ?? const [];
