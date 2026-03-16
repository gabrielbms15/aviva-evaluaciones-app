import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prevalencias/core/app_colors.dart';
import 'package:prevalencias/models/models.dart';
import 'package:prevalencias/widgets/prevalencias_app_bar.dart';
import 'package:prevalencias/data/app_data.dart';
import 'package:prevalencias/data/evaluation_repository.dart';



class NewEvaluationPage extends StatefulWidget {
  const NewEvaluationPage({super.key});

  @override
  State<NewEvaluationPage> createState() => _NewEvaluationPageState();
}

class _NewEvaluationPageState extends State<NewEvaluationPage> {
  final SearchController _upssSearchController = SearchController();
  final SearchController _staffSearchController = SearchController();

  ClinicalArea? _selectedUpss;
  StaffMember? _selectedStaff;
  int _upssPage = 0;
  int _staffPage = 0;

  static const int _upssPerPage = 3;
  static const int _staffPerPage = 4;

  void _resetSelection() {
    setState(() {
      _selectedUpss = null;
      _selectedStaff = null;
      _upssPage = 0;
      _staffPage = 0;
      _upssSearchController.clear();
      _staffSearchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: PrevalenciasAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildUpssSection(),
            const SizedBox(height: 32),
            _buildStaffSection(),
            const SizedBox(height: 48),
            _buildActionButtons(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _resetSelection,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.primaryBrown),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancelar',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBrown,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.main2],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: (_selectedUpss != null && _selectedStaff != null)
                  ? () {
                      EvaluationRepository.instance.startSession(
                        _selectedUpss!,
                        _selectedStaff!,
                      );
                      Navigator.pushReplacementNamed(context, '/form');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Empezar Evaluación',
                style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.publicSans(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
            children: [
              const TextSpan(
                text: 'Iniciar\n',
                style: TextStyle(color: Colors.black),
              ),
              const TextSpan(
                text: 'Evaluación',
                style: TextStyle(color: AppColors.main2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecciona la UPSS y el profesional de salud para empezar la revisión de competencias técnicas',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String number, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.7),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            number,
            style: GoogleFonts.publicSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.publicSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBrown,
          ),
        ),
      ],
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

  Widget _buildUpssSection() {
    final totalUpssPages = (clinicalAreas.length / _upssPerPage).ceil();
    final start = _upssPage * _upssPerPage;
    final displayUpss = clinicalAreas.skip(start).take(_upssPerPage).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader('1', 'Unidad de Salud'),
            _buildPaginator(
              currentPage: _upssPage,
              totalPages: totalUpssPages,
              onPrev: () => setState(() => _upssPage--),
              onNext: () => setState(() => _upssPage++),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SearchAnchor(
          searchController: _upssSearchController,
          viewConstraints: BoxConstraints(
            maxHeight: clinicalAreas.length * 72.0 + 40,
          ),
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () => controller.openView(),
              onChanged: (_) => controller.openView(),
              leading: const Icon(Icons.search, color: AppColors.main1),
              hintText: 'Buscar UPSS...',
              hintStyle: WidgetStatePropertyAll<TextStyle>(
                GoogleFonts.inter(color: Colors.grey),
              ),
              elevation: const WidgetStatePropertyAll<double>(0),
              backgroundColor: const WidgetStatePropertyAll<Color>(
                Colors.white,
              ),
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
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
                    leading: const Icon(
                      Icons.local_hospital,
                      color: AppColors.main1,
                    ),
                    title: Text(
                      area.name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      area.location,
                      style: GoogleFonts.inter(fontSize: 12),
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
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayUpss.length,
          itemBuilder: (context, index) {
            final area = displayUpss[index];
            final isSelected = _selectedUpss == area;
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.main1
                      : Colors.grey.withOpacity(0.2),
                  width: isSelected ? 2 : 1,
                ),
              ),
              color: isSelected
                  ? AppColors.main1.withOpacity(0.05)
                  : Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.main1.withOpacity(0.2)
                        : AppColors.main1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.business,
                    color: isSelected ? AppColors.primaryBlue : AppColors.main1,
                  ),
                ),
                title: Text(
                  area.name,
                  style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.primaryBrown,
                  ),
                ),
                subtitle: Text(
                  area.location,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: AppColors.main1)
                    : const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  setState(() {
                    _selectedUpss = area;
                    _selectedStaff = null;
                    _staffPage = 0;
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStaffSection() {
    // Only show staff for the selected area; if none selected, empty list.
    final List<StaffMember> areaStaff = _selectedUpss != null
        ? getStaffForArea(_selectedUpss!.id)
        : [];

    final totalStaffPages = areaStaff.isEmpty
        ? 1
        : (areaStaff.length / _staffPerPage).ceil();
    final start = _staffPage * _staffPerPage;
    final displayStaff = areaStaff.skip(start).take(_staffPerPage).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader('2', 'Miembro del staff'),
            if (areaStaff.length > _staffPerPage)
              _buildPaginator(
                currentPage: _staffPage,
                totalPages: totalStaffPages,
                onPrev: () => setState(() => _staffPage--),
                onNext: () => setState(() => _staffPage++),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SearchAnchor(
          searchController: _staffSearchController,
          viewConstraints: BoxConstraints(
            maxHeight: areaStaff.length * 72.0 + 40,
          ),
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () => controller.openView(),
              onChanged: (_) => controller.openView(),
              leading: const Icon(Icons.search, color: AppColors.main1),
              hintText: 'Buscar Miembro del staff...',
              hintStyle: WidgetStatePropertyAll<TextStyle>(
                GoogleFonts.inter(color: Colors.grey),
              ),
              elevation: const WidgetStatePropertyAll<double>(0),
              backgroundColor: const WidgetStatePropertyAll<Color>(
                Colors.white,
              ),
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
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
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFEFF4FF),
                      child: Icon(Icons.person, color: AppColors.main1),
                    ),
                    title: Text(
                      staff.name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      staff.role,
                      style: GoogleFonts.inter(fontSize: 12),
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
            childAspectRatio: 0.85,
          ),
          itemCount: displayStaff.length + (_staffPage == totalStaffPages - 1 ? 1 : 0), // +1 only on last page
          itemBuilder: (context, index) {
            if (index == displayStaff.length && _staffPage == totalStaffPages - 1) {
              return _buildAddStaffCard();
            }

            final staff = displayStaff[index];
            final isSelected = _selectedStaff == staff;
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.main1
                      : Colors.grey.withOpacity(0.2),
                  width: isSelected ? 2 : 1,
                ),
              ),
              color: isSelected
                  ? AppColors.main1.withOpacity(0.05)
                  : Colors.white,
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.main1.withOpacity(0.2)
                                  : AppColors.main1.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 32,
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.main1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            staff.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.primaryBrown,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            staff.role,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(height: 8),
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.main1,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),           // closes InkWell
                  ),           // closes Positioned.fill
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
                      onPressed: () => _showStaffModal(staffToEdit: staff),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddStaffCard() {
    return InkWell(
      onTap: () => _showStaffModal(),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.4),
            width: 2,
            style: BorderStyle.none, // Usually custom dash needed, but setting visual cue
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 28, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              'Añadir\nEmpleado',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStaffModal({StaffMember? staffToEdit}) {
    if (_selectedUpss == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una Unidad de Salud primero')),
      );
      return;
    }

    final isEditing = staffToEdit != null;
    final nameController = TextEditingController(text: isEditing ? staffToEdit.name : '');
    final roleController = TextEditingController(text: isEditing ? staffToEdit.role : '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEditing ? 'Editar Empleado' : 'Añadir Empleado',
            style: GoogleFonts.publicSans(fontWeight: FontWeight.bold, color: AppColors.primaryBrown),
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
              child: Text('Cancelar', style: GoogleFonts.inter(color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
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
                      _selectedStaff = StaffMember(id: staffToEdit.id, name: name, areaId: staffToEdit.areaId, role: role);
                    }
                  } else {
                    addStaffToArea(_selectedUpss!.id, name, role);
                  }
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(isEditing ? 'Guardar' : 'Añadir', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
