import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prevalencias/core/app_colors.dart';
import 'package:prevalencias/data/evaluation_repository.dart';
import 'package:prevalencias/models/models.dart';
import 'package:prevalencias/widgets/prevalencias_app_bar.dart';
import 'dart:ui';
import 'new_evaluation_page.dart';
import 'dashboard_page.dart';
import 'package:prevalencias/data/app_data.dart';
import 'package:prevalencias/login_page.dart';

void main() {
  runApp(const ClinicalAssessmentApp());
}

final List<FormCategory> _formCategories = [
  FormCategory(
    title: 'LAVADO DE MANOS',
    questions: [
      Question(
        id: '1.',
        text: 'Uñas cortas al borde de las yemas de los dedos y sin esmalte',
      ),
      Question(id: '3.', text: 'Apertura de llave de año y humedece manos'),
      Question(
        id: '4.',
        text: 'Deposita una cantidad de suficiente de jabón en las manos',
      ),
      Question(
        id: '5.',
        text:
            'Realiza frotado hasta obetener suficiente espuma en superficie de las manos',
      ),
      Question(id: '6.', text: 'Realiza el frotado de las palmas entre si'),
      Question(
        id: '7.',
        text:
            'Realiza el frotado de la palma den mano derecha contra el dorso de la mano izquierda entrelazando los dedos y viceversa',
      ),
      Question(
        id: '8.',
        text:
            'Realiza el frotado de la palma de las manos entre si, con los dedos entrelazados',
      ),
      Question(
        id: '9a.',
        text:
            'Realiza el frotado de dorso de los dedos, con la mano opuesta, agarrandose los dedos',
      ),
      Question(
        id: '9b.',
        text:
            'Realiza el frotado del pulgar izquierdo con un movimiento de rotación, atrapándolo con la palma de la mano derecha y viceversa',
      ),
      Question(
        id: '10.',
        text:
            'Realiza el frotado de la punta de los dedos de la mano derecha contra la palma de la mano izquierda haciendo un movimiento de rotacion y viceversa',
      ),
      Question(
        id: '11.',
        text:
            'Se enjuaga las manos de la parte distal hacia la proximal con agua a chorro moderado y no las sacude',
      ),
      Question(
        id: '12.',
        text:
            'Realiza el secado con papel toalla iniciando de las manos hacia los antebrazos',
      ),
      Question(
        id: '13.',
        text: 'Cierra la llave del caño utilizando el papel toalla',
      ),
      Question(
        id: '14.',
        text: 'La técnica empleada duró 60 segundos aproximadamente',
      ),
    ],
  ),
  FormCategory(
    title: 'ADMINISTRACION SEGURA DE MEDICAMENTOS',
    questions: [
      Question(
        id: '1.',
        text:
            '¿Conoce que existe un Procedimiento de Administración segura de Medicamentos?',
      ),
      Question(
        id: '2.',
        text: '¿Conoce donde puede encontrar el documento para lectura?',
      ),
      Question(id: '3.', text: '¿Conoce los 5 correctos?'),
      Question(
        id: '4.',
        text:
            '¿Aplica los criterios de verificación antes de dispensar algún producto o administrar medicamento, realizar algún procedimiento o actividad relacionado con el paciente?',
      ),
      Question(
        id: '5.',
        text: 'Verifica paciente, dosis, via, medicamento, hora correcta.',
      ),
      Question(
        id: '6.',
        text:
            '¿Ha recibido capacitación acerca de este procedimiento en los últimos 3 meses?',
      ),
      Question(
        id: '7.',
        text:
            'Personal conoce la ruta de notificación en caso de evento adverso relacionado error en la administración de medicamento',
      ),
    ],
  ),
  FormCategory(
    title: 'PREVENCION DEL RIESGO DE CAIDA',
    questions: [
      Question(
        id: '1.',
        text:
            'El personal conoce la existencia del procedimiento institucional para la prevención del riesgo de caídas',
      ),
      Question(
        id: '2.',
        text:
            'El personal conoce donde puede consultar el documento para lectura',
      ),
      Question(
        id: '3.',
        text:
            'El personal identifica la herramienta institucional utilizada para valorar el riesgo de caída',
      ),
      Question(
        id: '4.',
        text:
            'El personal reconoce las medidas preventivas que deben implementarse según nivel de riesgo identificado:.',
        subQuestions: [
          Question(id: '4.1', text: 'Colocación de brazalete amarillo'),
          Question(id: '4.2', text: 'Elevación de barandas (cuando aplique)'),
          Question(id: '4.3', text: 'Señalización visible de riesgo'),
          Question(
            id: '4.4',
            text: 'Timbre o medio de llamado al alcance del paciente',
          ),
          Question(
            id: '4.5',
            text: 'Uso de solla de ruedas o acompañamiento en traslados',
          ),
          Question(
            id: '4.6',
            text:
                'Supervisión durante procedimientos diagnósticos or consultas',
          ),
        ],
      ),
      Question(
        id: '5.',
        text:
            'El personal identifica correctamente el color del brazalete de riesgo de caida',
      ),
    ],
  ),
  FormCategory(
    title: 'IDENTIFICACION DEL PACIENTE',
    questions: [
      Question(
        id: '1.',
        text:
            'El personal conoce la existencia del procedimiento institucional para la Identificación correcta de paciente',
      ),
      Question(
        id: '2.',
        text:
            'El personal conoce donde puede consultar el documento para lectura',
      ),
      Question(
        id: '3.',
        text:
            'El personal conoce la herramienta institucional implementada para la identificación correcta del paciente',
      ),
      Question(
        id: '4.',
        text:
            'El personal menciona dos datos identificatorios del brazalete de identificación',
        subQuestions: [
          Question(id: '4.1', text: 'Nombres y apellidos completos'),
          Question(id: '4.2', text: 'Número del documento de identidad'),
          Question(id: '4.3', text: 'Fecha de nacimiento'),
          Question(id: '4.4', text: 'Sexo'),
          Question(id: '4.5', text: 'Fecha de ingreso'),
        ],
      ),
      Question(
        id: '5.',
        text:
            'Conoce el procedimiento en caso de error de datos identificatorios',
      ),
      Question(id: '6.', text: 'Conoce el procedimiento en caso de homonimia'),
      Question(
        id: '7.',
        text:
            'El personal reconoce el color del brazalete de identificación de paciente',
      ),
      Question(
        id: '8.',
        text:
            'Ha recibido capacitación acerca de este procedimiento en los últimos 3 meses',
      ),
      Question(id: '9.', text: 'Paciente porta brazalete de identificación'),
      Question(
        id: '10.',
        text:
            'Verificación de datos contenidos en el brazalete corresponde a los datos del paciente',
      ),
    ],
  ),
  FormCategory(
    title: 'COMUNICACIÓN SEGURA',
    questions: [
      Question(
        id: '1.',
        text:
            'El personal conoce la existencia del procedimiento institucional de Comunicación segura',
      ),
      Question(
        id: '2.',
        text:
            'El personal conoce donde puede consultar el documento para lectura',
      ),
      Question(
        id: '3.',
        text:
            'El personal conoce la herramienta institucional establecida para la transmisión estructurada de información clínica',
      ),
      Question(
        id: '4.',
        text: 'El personal aplica la metodología SBAR (utiliza la herramienta)',
      ),
      Question(
        id: '5.',
        text:
            'El personal define las siglas SBAR (Situación Antecedentes, Evaluación y Recomendaciones)',
      ),
      Question(
        id: '6.',
        text:
            'Conoce el procedimiento de comunicación de valores o resultados críticos',
      ),
      Question(
        id: '7.',
        text:
            'Ha recibido capacitación acerca de este procedimiento en los últimos 3 meses',
      ),
      Question(
        id: '8.',
        text:
            'Se verifica en los registros de la historia clínica el empleo de la técnica SBAR',
      ),
      Question(
        id: '9.',
        text:
            'Se verifica que los resultados críticos de laboratorio o imágenes diagnósticas son comunicados oportunamente y queda registro de la notificación.',
      ),
    ],
  ),
  FormCategory(
    title: 'PREVENCION DE UPP',
    questions: [
      Question(
        id: '1.',
        text:
            'El personal conoce la existencia del procedimiento institucional de Prevención de UPP',
      ),
      Question(
        id: '2.',
        text:
            'El personal conoce donde puede consultar el documento para lectura',
      ),
      Question(
        id: '3.',
        text:
            'El personal conoce la herramienta institucional establecida para la valoración de riesgo de UPP',
      ),
      Question(
        id: '4.',
        text:
            'El personal conoce la frecuencia con la que debe realizarse la escala de valoración de riesgo',
      ),
      Question(
        id: '5.',
        text: 'El personal identifica los principales factores de riesgo:',
        subQuestions: [
          Question(id: '5.1', text: 'Inmovilidad'),
          Question(id: '5.2', text: 'Humedad'),
          Question(id: '5.3', text: 'Desnutrición'),
          Question(id: '5.4', text: 'Fricción / Cizallamiento'),
          Question(id: '5.5', text: 'Dispositivos médicos'),
        ],
      ),
      Question(
        id: '6.',
        text:
            'El personal reconoce las medidas preventivas según nivel de riesgo',
        subQuestions: [
          Question(id: '6.1', text: 'Cambio postural cada 2 horas'),
          Question(id: '6.2', text: 'Hidratación de la piel'),
          Question(id: '6.3', text: 'soporte nutricional'),
          Question(
            id: '6.4',
            text:
                'Dispositivos médicos implementados: colchón antiescara, taloneras, cojines.',
          ),
        ],
      ),
      Question(
        id: '7.',
        text:
            'Personal conoce la ruta de notificación en caso de evento adverso relacionado a UPP',
      ),
      Question(
        id: '8.',
        text:
            'La historia clinica contiene la valoración de riesgo de UPP correctamente llenada',
      ),
      Question(
        id: '9.',
        text:
            'Se verifica reevaloración periódica with registro en historia clínica',
      ),
      Question(
        id: '10.',
        text:
            'Se realiza cambio de posición con frecuencia establecida y existe registro en historia clínica.',
      ),
    ],
  ),
];

class ClinicalAssessmentApp extends StatelessWidget {
  const ClinicalAssessmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prevalencias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006578),
          primary: const Color(0xFF006578),
          onPrimary: Colors.white,
          secondary: const Color(0xFF4596AB),
          onSecondary: Colors.white,
          error: const Color(0xFFBA1A1A),
          surface: const Color(0xFFF1F5F9),
          onSurface: const Color(0xFF0B1C30),
        ),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const LoginPage(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const NewEvaluationPage(),
        '/form': (_) => const AssessmentFormPage(),
        '/dashboard': (_) => const DashboardPage(),
      },
    );
  }
}

class AssessmentFormPage extends StatefulWidget {
  const AssessmentFormPage({super.key});

  @override
  State<AssessmentFormPage> createState() => _AssessmentFormPageState();
}

class _AssessmentFormPageState extends State<AssessmentFormPage> {
  EvaluationSession? _session;
  final TextEditingController _observationsController = TextEditingController();
  late PageController _staffPageController;
  late SearchController _searchController;
  int _currentFormIndex = 0;
  int _currentStaffIndex = 0;
  List<StaffMember> _areaStaff = [];

  @override
  void initState() {
    super.initState();
    _session = EvaluationRepository.instance.activeSession;
    if (_session == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.pushReplacementNamed(context, '/');
      });
      return;
    }
    _areaStaff = getStaffForArea(_session!.sede.id, _session!.area.id);
    _currentStaffIndex = _areaStaff.indexWhere(
      (s) => s.id == _session!.staff.id,
    );
    if (_currentStaffIndex < 0) _currentStaffIndex = 0;
    _staffPageController = PageController(initialPage: _currentStaffIndex);
    _searchController = SearchController();
    _syncObservations();
  }

  @override
  void dispose() {
    _observationsController.dispose();
    if (_session != null) {
      _staffPageController.dispose();
      _searchController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // While redirecting (no session), show a blank scaffold.
    if (_session == null) {
      return const Scaffold(body: SizedBox.shrink());
    }

    // Safety guard for form index
    if (_currentFormIndex < 0) _currentFormIndex = 0;
    if (_currentFormIndex >= _formCategories.length) {
      _currentFormIndex = _formCategories.length - 1;
    }

    FormCategory activeForm = _formCategories[_currentFormIndex];

    // Calculate compliance for active form
    int totalQuestions = 0;
    int compliantCount = 0;

    for (var q in activeForm.questions) {
      if (q.subQuestions != null) {
        for (var sq in q.subQuestions!) {
          totalQuestions++;
          final response = EvaluationRepository.instance.getResponse(
            _currentFormIndex,
            sq.id,
          );
          if (response == true) compliantCount++;
        }
      } else {
        totalQuestions++;
        final response = EvaluationRepository.instance.getResponse(
          _currentFormIndex,
          q.id,
        );
        if (response == true) compliantCount++;
      }
    }

    double compliance = totalQuestions > 0
        ? compliantCount / totalQuestions
        : 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: const PrevalenciasAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(totalQuestions, compliantCount, compliance),
              const SizedBox(height: 32),

              // Form Header with Navigation
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      activeForm.title,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: const Color(0xFF3F484B),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.chevron_left, size: 20),
                        color: const Color(0xFF4596AB),
                        onPressed: _currentFormIndex > 0
                            ? () {
                                setState(() {
                                  if (_currentFormIndex > 0) {
                                    _currentFormIndex--;
                                  }
                                  _syncObservations();
                                });
                              }
                            : null,
                      ),
                      Text(
                        '${_currentFormIndex + 1} / ${_formCategories.length}',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4596AB),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.chevron_right, size: 20),
                        color: const Color(0xFF4596AB),
                        onPressed:
                            _currentFormIndex < _formCategories.length - 1
                            ? () {
                                setState(() {
                                  if (_currentFormIndex <
                                      _formCategories.length - 1) {
                                    _currentFormIndex++;
                                  }
                                  _syncObservations();
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Questions
              ...activeForm.questions
                  .map((q) => _buildQuestionCard(q))
                  .toList(),

              _buildObservationsSection(),
              const SizedBox(height: 48),
              _buildFinishButton(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── SEARCH BAR (scoped to area staff) ──────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SearchAnchor(
        searchController: _searchController,
        viewConstraints: BoxConstraints(
          maxHeight: _areaStaff.length * 72.0 + 40,
        ),
        builder: (BuildContext context, SearchController controller) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SearchBar(
                controller: controller,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.05,
                ),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () => controller.openView(),
                onChanged: (_) => controller.openView(),
                leading: const Icon(Icons.search, color: AppColors.main1),
                hintText: 'Buscar personal del área...',
                hintStyle: WidgetStatePropertyAll<TextStyle>(
                  GoogleFonts.inter(
                    color: AppColors.primaryBrown.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                elevation: const WidgetStatePropertyAll<double>(0),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.white.withOpacity(0.7),
                ),
                side: WidgetStatePropertyAll<BorderSide>(
                  BorderSide(color: Colors.white.withOpacity(0.5), width: 1.5),
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
              final keyword = controller.value.text.toLowerCase();
              final filtered = _areaStaff
                  .where((s) => s.name.toLowerCase().contains(keyword))
                  .toList();
              return filtered.map((staff) {
                final idx = _areaStaff.indexOf(staff);
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFEFF4FF),
                    child: Icon(Icons.person, color: Color(0xFF006578)),
                  ),
                  title: Text(
                    staff.name,
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    staff.role,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onTap: () {
                    controller.closeView('');
                    _switchToStaff(idx);
                  },
                );
              }).toList();
            },
      ),
    );
  }

  void _switchToStaff(int index) {
    setState(() {
      _currentStaffIndex = index;
      // Update the active session to reflect the newly selected staff
      EvaluationRepository.instance.startSession(
        _session!.sede,
        _session!.area,
        _areaStaff[index],
      );
      _session = EvaluationRepository.instance.activeSession;
      _staffPageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _syncObservations();
    });
  }

  // ── HERO SECTION (swipeable carousel + dots) ───────────

  Widget _buildHeroSection(int total, int compliant, double compliance) {
    final area = _session!.area;
    return Column(
      children: [
        _buildSearchBar(),
        Container(
          constraints: const BoxConstraints(minHeight: 140),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF006578), Color(0xFF287E93)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF006578).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EVALUACIÓN ACTIVA',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFAEECFF),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 85,
                            child: PageView.builder(
                              controller: _staffPageController,
                              key: const PageStorageKey('staff_carousel'),
                              itemCount: _areaStaff.length,
                              onPageChanged: (index) => _switchToStaff(index),
                              itemBuilder: (context, index) {
                                final staff = _areaStaff[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      staff.name,
                                      style: GoogleFonts.publicSans(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      area.name,
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '• ${staff.role}',
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${_currentStaffIndex + 1} / ${_areaStaff.length}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildComplianceCard(compliant, total, compliance),
      ],
    );
  }

  Widget _buildComplianceCard(int value, int total, double percent) {
    final percentage = (percent * 100).toInt();
    final primaryColor = AppColors.main1;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.main1.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.analytics_rounded,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Cumplimiento',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBrown,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$percentage%',
                    style: GoogleFonts.publicSans(
                      color: AppColors.main2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percent,
                  minHeight: 8,
                  backgroundColor: Colors.white.withOpacity(0.6),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progreso',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$value ',
                          style: GoogleFonts.publicSans(
                            color: AppColors.primaryBrown,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'de $total',
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Question q) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${q.id} ${q.text}',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0B1C30),
              height: 1.5,
            ),
          ),
          if (q.subQuestions == null) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildResponseButton(q.id, 'Sí', true)),
                const SizedBox(width: 12),
                Expanded(child: _buildResponseButton(q.id, 'No', false)),
              ],
            ),
          ] else ...[
            const SizedBox(height: 20),
            ...q.subQuestions!
                .map(
                  (sq) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${sq.id} ${sq.text}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF3F484B),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 120,
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildMiniResponseButton(
                                  sq.id,
                                  'Sí',
                                  true,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildMiniResponseButton(
                                  sq.id,
                                  'No',
                                  false,
                                ),
                              ),
                            ].toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildResponseButton(String qId, String label, bool value) {
    bool isSelected =
        EvaluationRepository.instance.getResponse(_currentFormIndex, qId) ==
        value;
    Color activeColor = value
        ? const Color(0xFF9DE1FD)
        : const Color(0xFFFFDAD6);
    Color activeTextColor = value
        ? const Color(0xFF13657E)
        : const Color(0xFF93000A);
    Color activeBorderColor = value
        ? const Color(0xFF15667F)
        : const Color(0xFFBA1A1A);

    return GestureDetector(
      onTap: () => setState(() {
        final cur = EvaluationRepository.instance.getResponse(
          _currentFormIndex,
          qId,
        );
        EvaluationRepository.instance.saveResponse(
          _currentFormIndex,
          qId,
          cur == value ? null : value,
        );
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? activeBorderColor : const Color(0xFFDCE9FF),
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: isSelected ? activeTextColor : const Color(0xFF3F484B),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniResponseButton(String qId, String label, bool value) {
    bool isSelected =
        EvaluationRepository.instance.getResponse(_currentFormIndex, qId) ==
        value;
    Color activeColor = value
        ? const Color(0xFF9DE1FD)
        : const Color(0xFFFFDAD6);
    Color activeTextColor = value
        ? const Color(0xFF13657E)
        : const Color(0xFF93000A);

    return GestureDetector(
      onTap: () => setState(() {
        final cur = EvaluationRepository.instance.getResponse(
          _currentFormIndex,
          qId,
        );
        EvaluationRepository.instance.saveResponse(
          _currentFormIndex,
          qId,
          cur == value ? null : value,
        );
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? activeTextColor : const Color(0xFF3F484B),
          ),
        ),
      ),
    );
  }

  Widget _buildObservationsSection() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OBSERVACIONES ADICIONALES',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: const Color(0xFF3F484B),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _observationsController,
            onChanged: (val) {
              EvaluationRepository.instance.saveObservation(
                _currentFormIndex,
                val,
              );
            },
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Escriba aquí cualquier observación relevante...',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF3F484B).withOpacity(0.5),
                fontSize: 14,
              ),
              filled: true,
              fillColor: const Color(0xFFEFF4FF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  void _syncObservations() {
    _observationsController.text = EvaluationRepository.instance.getObservation(
      _currentFormIndex,
    );
  }

  Widget _buildFinishButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF006578), Color(0xFF287E93)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF006578).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Finish Evaluation',
          style: GoogleFonts.publicSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border(
          top: BorderSide(color: const Color(0xFFBEC8CC).withOpacity(0.2)),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.dashboard_outlined, 'Dashboard', false, () {
            Navigator.pushNamed(context, '/dashboard');
          }),
          _buildNavItem(Icons.add_circle, 'New', true, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewEvaluationPage(),
              ),
            );
          }),
          _buildNavItem(Icons.assessment_outlined, 'Reports', false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    Color color = isActive ? AppColors.primaryBlue : const Color(0xFF3F484B);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: isActive ? 28 : 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: color,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
