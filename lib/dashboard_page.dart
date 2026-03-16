import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prevalencias/core/app_colors.dart';
import 'package:prevalencias/widgets/prevalencias_app_bar.dart';

// ─────────────────────────────────────────────────────────
//  DUMMY DATA  — Replace with real data from repository
// ─────────────────────────────────────────────────────────

const int _totalForms = 420; // 14 UPSS × 5 staff × 6 forms
const int _completedForms = 48;
const int _totalUpss = 14;
const int _evaluatedUpss = 5;
const double _overallCompliance = 72.0;

/// Progress per UPSS (% of forms completed in that area).
const List<_UpssProgress> _upssProgressData = [
  _UpssProgress('Consulta Ext.', 85),
  _UpssProgress('Emergencia', 70),
  _UpssProgress('C. Obstétrico', 60),
  _UpssProgress('C. Quirúrgico', 45),
  _UpssProgress('UCI', 30),
];

/// Compliance per form type (Sí / No / Parcial percentages).
const List<_FormCompliance> _formComplianceData = [
  _FormCompliance('Lavado de Manos', 78, 15, 7),
  _FormCompliance('Medicamentos', 65, 25, 10),
  _FormCompliance('Prevención Caídas', 82, 12, 6),
  _FormCompliance('Úlceras Presión', 58, 30, 12),
  _FormCompliance('Identificación Pac.', 90, 5, 5),
  _FormCompliance('Cirugía Segura', 70, 20, 10),
];

class _UpssProgress {
  final String name;
  final double percent;
  const _UpssProgress(this.name, this.percent);
}

class _FormCompliance {
  final String title;
  final double yes;
  final double no;
  final double partial;
  const _FormCompliance(this.title, this.yes, this.no, this.partial);
}

// ─────────────────────────────────────────────────────────
//  COLORS
// ─────────────────────────────────────────────────────────

const Color _colorYes = Color(0xFF2ECC71);
const Color _colorNo = Color(0xFFE74C3C);
const Color _colorPartial = Color(0xFFF39C12);
const Color _bgColor = Color(0xFFF1F5F9);

// ─────────────────────────────────────────────────────────
//  PAGE
// ─────────────────────────────────────────────────────────

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: PrevalenciasAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSummaryCards(),
            const SizedBox(height: 32),
            _buildSectionTitle('Progreso por UPSS'),
            const SizedBox(height: 16),
            _buildUpssBarChart(),
            const SizedBox(height: 32),
            _buildSectionTitle('Cumplimiento por Proceso'),
            const SizedBox(height: 16),
            _buildComplianceGrid(),
            const SizedBox(height: 32),
            _buildSectionTitle('Tendencia de Cumplimiento'),
            const SizedBox(height: 16),
            _buildTrendLineChart(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ── 1. HEADER ──────────────────────────────────────────

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dashboard',
          style: GoogleFonts.publicSans(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBrown,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Resumen general del monitoreo de procesos',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // ── 2. SUMMARY CARDS ───────────────────────────────────

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            icon: Icons.check_circle_outline,
            iconColor: _colorYes,
            title: 'Completados',
            value: '$_completedForms / $_totalForms',
            subtitle: 'formularios',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: Icons.local_hospital,
            iconColor: AppColors.main1,
            title: 'UPSS',
            value: '$_evaluatedUpss / $_totalUpss',
            subtitle: 'evaluadas',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: Icons.show_chart,
            iconColor: AppColors.primaryBlue,
            title: 'Cumplimiento',
            value: '${_overallCompliance.toInt()}%',
            subtitle: 'general',
          ),
        ),
      ],
    );
  }

  // ── 3. UPSS BAR CHART ─────────────────────────────────

  Widget _buildUpssBarChart() {
    return Container(
      height: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          maxY: 100,
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 25,
            getDrawingHorizontalLine: (val) => FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 25,
                getTitlesWidget: (val, _) => Text(
                  '${val.toInt()}%',
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (val, _) {
                  final idx = val.toInt();
                  if (idx < 0 || idx >= _upssProgressData.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _upssProgressData[idx].name,
                      style: GoogleFonts.inter(fontSize: 9, color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(_upssProgressData.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: _upssProgressData[i].percent,
                  width: 24,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                  gradient: const LinearGradient(
                    colors: [AppColors.main1, AppColors.main2],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            );
          }),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIdx, rod, rodIdx) {
                return BarTooltipItem(
                  '${rod.toY.toInt()}%',
                  GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ── 4. COMPLIANCE GRID (Pie charts) ────────────────────

  Widget _buildComplianceGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: _formComplianceData.length,
      itemBuilder: (_, i) => _ComplianceCard(data: _formComplianceData[i]),
    );
  }

  // ── 5. TREND LINE CHART ────────────────────────────────

  Widget _buildTrendLineChart() {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 25,
            getDrawingHorizontalLine: (val) => FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 25,
                getTitlesWidget: (val, _) => Text(
                  '${val.toInt()}%',
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: 1,
                getTitlesWidget: (val, _) {
                  final labels = ['LM', 'MED', 'CAÍ', 'ÚLC', 'IDEN', 'CIR'];
                  final idx = val.toInt();
                  if (idx < 0 || idx >= labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[idx],
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(_formComplianceData.length, (i) {
                return FlSpot(i.toDouble(), _formComplianceData[i].yes);
              }),
              isCurved: true,
              curveSmoothness: 0.35,
              gradient: const LinearGradient(
                colors: [AppColors.main1, AppColors.primaryBlue],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                  radius: 5,
                  color: Colors.white,
                  strokeWidth: 2.5,
                  strokeColor: AppColors.primaryBlue,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.main1.withOpacity(0.25),
                    AppColors.primaryBlue.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => spots.map((s) {
                return LineTooltipItem(
                  '${s.y.toInt()}%',
                  GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // ── HELPERS ────────────────────────────────────────────

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.publicSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryBrown,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
//  WIDGETS
// ─────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  const _SummaryCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.publicSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B1C30),
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComplianceCard extends StatelessWidget {
  final _FormCompliance data;
  const _ComplianceCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 90,
            height: 90,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 22,
                sections: [
                  PieChartSectionData(
                    value: data.yes,
                    color: _colorYes,
                    radius: 18,
                    title: '',
                  ),
                  PieChartSectionData(
                    value: data.no,
                    color: _colorNo,
                    radius: 18,
                    title: '',
                  ),
                  PieChartSectionData(
                    value: data.partial,
                    color: _colorPartial,
                    radius: 18,
                    title: '',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot(_colorYes, '${data.yes.toInt()}%'),
              const SizedBox(width: 8),
              _legendDot(_colorNo, '${data.no.toInt()}%'),
              const SizedBox(width: 8),
              _legendDot(_colorPartial, '${data.partial.toInt()}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
