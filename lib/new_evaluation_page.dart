import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prevalencias/core/app_colors.dart';
import 'package:prevalencias/models/models.dart';
import 'package:prevalencias/widgets/prevalencias_app_bar.dart';
import 'package:prevalencias/widgets/prevalencias_search_bar.dart';
import 'package:prevalencias/data/app_data.dart';
import 'package:prevalencias/data/evaluation_repository.dart';
import 'dart:ui';

class NewEvaluationPage extends StatefulWidget {
  const NewEvaluationPage({super.key});

  @override
  State<NewEvaluationPage> createState() => _NewEvaluationPageState();
}

class _NewEvaluationPageState extends State<NewEvaluationPage> {
  final SearchController _upssSearchController = SearchController();
  final SearchController _staffSearchController = SearchController();

  Sede? _selectedSede;
  ClinicalArea? _selectedUpss;
  StaffMember? _selectedStaff;
  int _upssPage = 0;
  int _staffPage = 0;
  int _currentStep = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _upssSearchController.dispose();
    _staffSearchController.dispose();
    super.dispose();
  }

  static const int _upssPerPage = 3;
  static const int _staffPerPage = 4;

  @override
  Widget build(BuildContext context) {
    bool canContinue = false;
    if (_currentStep == 0) canContinue = _selectedSede != null;
    if (_currentStep == 1) canContinue = _selectedUpss != null;
    if (_currentStep == 2) canContinue = _selectedStaff != null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrevalenciasAppBar(),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.main1.withOpacity(0.15),
                  AppColors.main2.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16,
                  ),
                  child: _buildHeader(_currentStep),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (int page) {
                      setState(() {
                        _currentStep = page;
                      });
                    },
                    children: [
                      _buildWizardStep(child: _buildSedeSection()),
                      _buildWizardStep(child: _buildUpssSection()),
                      _buildWizardStep(child: _buildStaffSection()),
                    ],
                  ),
                ),
                _buildWizardNavigation(canContinue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWizardStep({required Widget child}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: child,
    );
  }

  Widget _buildWizardNavigation(bool canContinue) {
    bool isFirstStep = _currentStep == 0;
    bool isLastStep = _currentStep == 2;
    final double primaryBtnWidth = MediaQuery.of(context).size.width * 0.35;
    final double backBtnWidth = MediaQuery.of(context).size.width * 0.35;

    return ClipRect(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.4))),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Step Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: index == _currentStep ? 24 : 8,
                    decoration: BoxDecoration(
                      color: index == _currentStep
                          ? AppColors.main1
                          : AppColors.main1.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              // Navigation Buttons
              Row(
                mainAxisAlignment: isFirstStep
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (!isFirstStep)
                    SizedBox(
                      width: backBtnWidth,
                      child: TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Atrás',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 102, 102, 102),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: primaryBtnWidth,
                    child: _buildActionButton(canContinue, isLastStep),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(bool canContinue, bool isLastStep) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Container(
        decoration: BoxDecoration(
          color: canContinue
              ? AppColors.navyBlue.withOpacity(0.7)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
          boxShadow: canContinue
              ? [
                  BoxShadow(
                    color: AppColors.navyBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: ElevatedButton(
          onPressed: canContinue
              ? () {
                  if (!isLastStep) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    EvaluationRepository.instance.startSession(
                      _selectedSede!,
                      _selectedUpss!,
                      _selectedStaff!,
                    );
                    Navigator.pushReplacementNamed(context, '/form');
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            isLastStep ? 'Iniciar' : 'Continuar',
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: canContinue ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int currentStep) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.publicSans(
              fontSize: 32,
              height: 1.1,
              letterSpacing: -1.0,
            ),
            children: [
              TextSpan(
                text: 'Iniciar\n',
                style: GoogleFonts.publicSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: AppColors.main2,
                ),
              ),
              TextSpan(
                text: 'Evaluación',
                style: GoogleFonts.publicSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.headerColor5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecciona la sede, UPSS y el personal para empezar la evaluación de prevalencias',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        _buildStepIndicators(currentStep),
      ],
    );
  }

  Widget _buildStepIndicators(int currentStep) {
    final steps = ['Sede', 'UPSS', 'Staff'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            final stepBeforeActive = (i ~/ 2) < currentStep;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.chevron_right,
                color: stepBeforeActive
                    ? AppColors.main1.withOpacity(0.5)
                    : Colors.grey.shade300,
                size: 20,
              ),
            );
          }

          final index = i ~/ 2;
          final isActive = index <= currentStep;
          final isCurrent = index == currentStep;

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Paso ${index + 1}',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isActive ? AppColors.main1 : Colors.grey.shade400,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  steps[index],
                  style: GoogleFonts.publicSans(
                    fontSize: 14,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                    color: isActive
                        ? AppColors.primaryBrown
                        : Colors.grey.shade400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPaginator({
    required int currentPage,
    required int totalPages,
    required VoidCallback onPrev,
    required VoidCallback onNext,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: currentPage > 0 ? onPrev : null,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Icon(
              Icons.chevron_left,
              size: 20,
              color: currentPage > 0 ? AppColors.main1 : Colors.grey.shade300,
            ),
          ),
        ),
        Text(
          '${currentPage + 1} / $totalPages',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.main1,
          ),
        ),
        InkWell(
          onTap: currentPage < totalPages - 1 ? onNext : null,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Icon(
              Icons.chevron_right,
              size: 20,
              color: currentPage < totalPages - 1
                  ? AppColors.main1
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSedeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: sedes.map((sede) {
            final isSelected = _selectedSede == sede;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: sede == sedes.first ? 8.0 : 0.0,
                  left: sede == sedes.last ? 8.0 : 0.0,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_selectedSede != sede) {
                        _selectedSede = sede;
                        _selectedUpss = null; // Reset dependants
                        _selectedStaff = null;
                        _upssPage = 0;
                        _staffPage = 0;
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.main1.withOpacity(0.8)
                              : Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.main1.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              sede.imagePath,
                              height: 130,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    height: 100,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                sede.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.publicSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.primaryBrown,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildUpssSection() {
    final totalUpssPages = (clinicalAreas.length / _upssPerPage).ceil();
    final start = _upssPage * _upssPerPage;
    final displayUpss = clinicalAreas.skip(start).take(_upssPerPage).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        PrevalenciasSearchBar(
          controller: _upssSearchController,
          hintText: 'Buscar UPSS...',
          itemCount: clinicalAreas.length,
          padding: const EdgeInsets.only(bottom: 0),
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
                final String keyword = controller.value.text.toLowerCase();
                final List<ClinicalArea> filteredUpss = clinicalAreas.where((
                  area,
                ) {
                  return area.name.toLowerCase().contains(keyword);
                }).toList();

                return filteredUpss.map((area) {
                  return ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    leading: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFEFF4FF),
                      child: Icon(
                        Icons.local_hospital,
                        size: 16,
                        color: AppColors.main1,
                      ),
                    ),
                    title: Text(
                      area.name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.primaryBrown,
                      ),
                    ),
                    subtitle: Text(
                      area.location,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBrown.withOpacity(0.6),
                      ),
                    ),
                    onTap: () {
                      controller.closeView('');
                      setState(() {
                        _selectedUpss = area;
                        _selectedStaff = null;
                        _staffPage = 0;
                      });
                    },
                  );
                }).toList();
              },
        ),

        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayUpss.length,
          itemBuilder: (context, index) {
            final area = displayUpss[index];
            final isSelected = _selectedUpss == area;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      color: isSelected
                          ? AppColors.main1.withOpacity(0.8)
                          : Colors.white.withOpacity(0.15),
                      child: Center(
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          minVerticalPadding: 0,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : AppColors.main1.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.business,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.main1,
                            ),
                          ),
                          title: Text(
                            area.name,
                            style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.primaryBrown,
                            ),
                          ),
                          subtitle: Text(
                            area.location,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: isSelected
                                  ? Colors.white.withOpacity(0.8)
                                  : const Color(0xFF4B5563),
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                ),
                          onTap: () {
                            setState(() {
                              _selectedUpss = area;
                              _selectedStaff = null;
                              _staffPage = 0;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildPaginator(
              currentPage: _upssPage,
              totalPages: totalUpssPages,
              onPrev: () => setState(() => _upssPage--),
              onNext: () => setState(() => _upssPage++),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStaffSection() {
    // Only show staff for the selected area; if none selected, empty list.
    final List<StaffMember> areaStaff =
        (_selectedSede != null && _selectedUpss != null)
        ? getStaffForArea(_selectedSede!.id, _selectedUpss!.id)
        : [];

    final totalStaffPages = areaStaff.isEmpty
        ? 1
        : (areaStaff.length / _staffPerPage).ceil();
    final start = _staffPage * _staffPerPage;
    final displayStaff = areaStaff.skip(start).take(_staffPerPage).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        PrevalenciasSearchBar(
          controller: _staffSearchController,
          hintText: 'Buscar Miembro del staff...',
          itemCount: areaStaff.length,
          padding: const EdgeInsets.only(bottom: 0),
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
                final String keyword = controller.value.text.toLowerCase();
                final List<StaffMember> filteredStaff = areaStaff.where((
                  staff,
                ) {
                  return staff.name.toLowerCase().contains(keyword);
                }).toList();

                return filteredStaff.map((staff) {
                  return ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    leading: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFEFF4FF),
                      child: Icon(
                        Icons.person,
                        size: 16,
                        color: AppColors.main1,
                      ),
                    ),
                    title: Text(
                      staff.name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.primaryBrown,
                      ),
                    ),
                    subtitle: Text(
                      staff.role,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBrown.withOpacity(0.6),
                      ),
                    ),
                    onTap: () {
                      controller.closeView('');
                      setState(() {
                        _selectedStaff = staff;
                      });
                    },
                  );
                }).toList();
              },
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.98,
          ),
          itemCount:
              displayStaff.length +
              (_staffPage == totalStaffPages - 1
                  ? 1
                  : 0), // +1 only on last page
          itemBuilder: (context, index) {
            if (index == displayStaff.length &&
                _staffPage == totalStaffPages - 1) {
              return _buildAddStaffCard();
            }

            final staff = displayStaff[index];
            final isSelected = _selectedStaff == staff;
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  color: isSelected
                      ? AppColors.main1.withOpacity(0.8)
                      : Colors.white.withOpacity(0.15),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedStaff = staff;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white.withOpacity(0.2)
                                        : AppColors.main1.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 24,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.main1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _toTitleCase(staff.name),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.publicSans(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.primaryBrown,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  staff.role,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: isSelected
                                        ? Colors.white.withOpacity(0.8)
                                        : const Color(0xFF4B5563),
                                  ),
                                ),
                                if (isSelected) ...[
                                  const SizedBox(height: 4),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ), // closes InkWell
                      ), // closes Positioned.fill
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.edit,
                            size: 14,
                            color: isSelected
                                ? Colors.white.withOpacity(0.8)
                                : const Color(0xFF4B5563),
                          ),
                          onPressed: () => _showStaffModal(staffToEdit: staff),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        if (areaStaff.length > _staffPerPage)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPaginator(
                currentPage: _staffPage,
                totalPages: totalStaffPages,
                onPrev: () => setState(() => _staffPage--),
                onNext: () => setState(() => _staffPage++),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildAddStaffCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: InkWell(
          onTap: () => _showStaffModal(),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 28,
                    color: AppColors.main1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Añadir\nEmpleado',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBrown,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStaffModal({StaffMember? staffToEdit}) {
    if (_selectedUpss == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una Unidad de Salud primero'),
        ),
      );
      return;
    }

    final isEditing = staffToEdit != null;
    final nameController = TextEditingController(
      text: isEditing ? staffToEdit.name : '',
    );
    final roleController = TextEditingController(
      text: isEditing ? staffToEdit.role : '',
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            isEditing ? 'Editar Empleado' : 'Añadir Empleado',
            style: GoogleFonts.publicSans(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBrown,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: 'Rol (Ej: Médico, Enfermera)',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: GoogleFonts.inter(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final role = roleController.text.trim();
                if (name.isEmpty || role.isEmpty) return;

                setState(() {
                  if (isEditing) {
                    updateStaff(staffToEdit.id, name, role);
                    // Update current selection if editing the selected staff
                    if (_selectedStaff?.id == staffToEdit.id) {
                      _selectedStaff = StaffMember(
                        id: staffToEdit.id,
                        name: name,
                        sedeId: staffToEdit.sedeId,
                        areaId: staffToEdit.areaId,
                        role: role,
                      );
                    }
                  } else {
                    addStaffToArea(
                      _selectedSede!.id,
                      _selectedUpss!.id,
                      name,
                      role,
                    );
                  }
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isEditing ? 'Guardar' : 'Añadir',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .toLowerCase()
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
