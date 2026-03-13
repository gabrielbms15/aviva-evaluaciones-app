import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prevalencias/core/app_colors.dart';
import 'package:prevalencias/models/models.dart';
import 'package:prevalencias/widgets/prevalencias_app_bar.dart';
import 'main.dart';

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
  bool _showAllUpss = false;
  bool _showAllStaff = false;

  void _resetSelection() {
    setState(() {
      _selectedUpss = null;
      _selectedStaff = null;
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
                      // Future: Start Evaluation Navigation here
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
        Text(
          'Iniciar Evaluación',
          style: GoogleFonts.publicSans(
            fontSize: 28,
            fontWeight: FontWeight.w750,
            color: Color(0xFF000000),
            letterSpacing: -0.5,
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
            color: AppColors.primaryBlue,
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

  Widget _buildUpssSection() {
    final displayUpss = _showAllUpss
        ? clinicalAreas
        : clinicalAreas.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader('1', 'UPSS / Área Clínica'),
            if (clinicalAreas.length > 3)
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAllUpss = !_showAllUpss;
                  });
                },
                child: Text(
                  _showAllUpss ? 'Ver menos' : 'Ver más +',
                  style: GoogleFonts.inter(
                    color: AppColors.main1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
    final displayStaff = _showAllStaff
        ? staffMembers
        : staffMembers.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader('2', 'Miembro del staff'),
            if (staffMembers.length > 3)
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAllStaff = !_showAllStaff;
                  });
                },
                child: Text(
                  _showAllStaff ? 'Ver menos' : 'Ver más +',
                  style: GoogleFonts.inter(
                    color: AppColors.main1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SearchAnchor(
          searchController: _staffSearchController,
          viewConstraints: BoxConstraints(
            maxHeight: staffMembers.length * 72.0 + 40,
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
                final List<StaffMember> filteredStaff = staffMembers.where((
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
          itemCount: displayStaff.length,
          itemBuilder: (context, index) {
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
              ),
            );
          },
        ),
      ],
    );
  }
}
