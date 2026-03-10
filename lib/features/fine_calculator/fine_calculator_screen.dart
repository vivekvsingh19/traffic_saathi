import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/violation.dart';
import 'fine_result_screen.dart';

class FineCalculatorScreen extends StatefulWidget {
  const FineCalculatorScreen({super.key});

  @override
  State<FineCalculatorScreen> createState() => _FineCalculatorScreenState();
}

class _FineCalculatorScreenState extends State<FineCalculatorScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Violation? selectedViolation;
  bool? isFirstOffence;
  bool? isCommercialVehicle;
  bool? isAccidentInvolved;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _calculateAndNavigate();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<Color> _getProgressColors(int index) {
    switch (index) {
      case 0:
        return [const Color(0xFF6D28D9), const Color(0xFF7C3AED)]; // Purple
      case 1:
        return [const Color(0xFF0D9488), const Color(0xFF14B8A6)]; // Teal
      case 2:
        return [const Color(0xFFDC2626), const Color(0xFFEF4444)]; // Red
      case 3:
        return [const Color(0xFF1E40AF), const Color(0xFF3B82F6)]; // Blue
      default:
        return [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)];
    }
  }

  IconData _getViolationIcon(String title) {
    if (title.contains('Helmet')) return CupertinoIcons.shield_fill;
    if (title.contains('Seatbelt')) return CupertinoIcons.car_detailed;
    if (title.contains('Triple Riding')) return CupertinoIcons.person_2_fill;
    if (title.contains('Speeding')) return CupertinoIcons.gauge;
    if (title.contains('Drink')) return CupertinoIcons.drop_fill;
    if (title.contains('Registration')) return CupertinoIcons.doc_text_fill;
    if (title.contains('License')) return CupertinoIcons.creditcard_fill;
    if (title.contains('Insurance')) return CupertinoIcons.shield_lefthalf_fill;
    if (title.contains('Wrong Side')) return CupertinoIcons.arrow_left_right;
    if (title.contains('Mobile')) return CupertinoIcons.device_phone_portrait;
    if (title.contains('Red Light')) return CupertinoIcons.stop_circle_fill;
    if (title.contains('Pollution'))
      return CupertinoIcons.leaf_arrow_circlepath;
    return CupertinoIcons.exclamationmark_triangle_fill;
  }

  void _calculateAndNavigate() {
    if (selectedViolation == null) return;

    int baseFine = (isFirstOffence ?? true)
        ? selectedViolation!.fineFirst
        : selectedViolation!.fineRepeat;

    if (isCommercialVehicle == true) {
      baseFine = (baseFine * 1.25).toInt();
    }

    if (isAccidentInvolved == true) {
      baseFine = (baseFine * 1.5).toInt();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FineResultScreen(
          violation: selectedViolation!,
          totalFine: baseFine,
          isFirstOffence: isFirstOffence ?? true,
          isCommercialVehicle: isCommercialVehicle ?? false,
          isAccidentInvolved: isAccidentInvolved ?? false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(
                  CupertinoIcons.back,
                  color: AppTheme.darkAccent,
                ),
                onPressed: _previousPage,
              )
            : IconButton(
                icon: const Icon(
                  CupertinoIcons.back,
                  color: AppTheme.darkAccent,
                ),
                onPressed: () => Navigator.pop(context),
              ),
        title: Text(
          'Fine Calculator',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator with gradient
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: index <= _currentPage
                            ? LinearGradient(
                                colors: _getProgressColors(index),
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        color: index <= _currentPage
                            ? null
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  _buildViolationSelection(),
                  _buildOffenceTypeSelection(),
                  _buildVehicleTypeSelection(),
                  _buildAccidentSelection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViolationSelection() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildStepHeader('1', 'Select Violation Type', 'What rule was broken?'),
        const SizedBox(height: 24),
        ...mockViolations.map((violation) {
          final isSelected = selectedViolation == violation;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                setState(() => selectedViolation = violation);
                _nextPage();
              },
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: const [Color(0xFF6D28D9), Color(0xFF7C3AED)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6D28D9)
                        : Colors.grey.shade200,
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF6D28D9,
                            ).withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.2)
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getViolationIcon(violation.title),
                        size: 24,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            violation.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.darkAccent,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${violation.fineFirst} - ₹${violation.fineRepeat}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.8)
                                  : AppTheme.subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isSelected
                          ? CupertinoIcons.checkmark_circle_fill
                          : CupertinoIcons.arrow_right_circle_fill,
                      size: 28,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF1E3A8A).withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOffenceTypeSelection() {
    return _buildSelectionPage(
      step: '2',
      title: 'Offence History',
      subtitle: 'Is this the first time?',
      children: [
        Row(
          children: [
            Expanded(
              child: _OptionCard(
                icon: CupertinoIcons.number_circle_fill,
                label: 'First Time',
                isSelected: isFirstOffence == true,
                onTap: () {
                  setState(() => isFirstOffence = true);
                  _nextPage();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _OptionCard(
                icon: CupertinoIcons.repeat,
                label: 'Repeated',
                isSelected: isFirstOffence == false,
                onTap: () {
                  setState(() => isFirstOffence = false);
                  _nextPage();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleTypeSelection() {
    return _buildSelectionPage(
      step: '3',
      title: 'Vehicle Type',
      subtitle: 'What kind of vehicle?',
      children: [
        Row(
          children: [
            Expanded(
              child: _OptionCard(
                icon: CupertinoIcons.car_fill,
                label: 'Personal',
                isSelected: isCommercialVehicle == false,
                onTap: () {
                  setState(() => isCommercialVehicle = false);
                  _nextPage();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _OptionCard(
                icon: CupertinoIcons.bus,
                label: 'Commercial',
                subtitle: '+25% Fine',
                isSelected: isCommercialVehicle == true,
                onTap: () {
                  setState(() => isCommercialVehicle = true);
                  _nextPage();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccidentSelection() {
    return _buildSelectionPage(
      step: '4',
      title: 'Accident Status',
      subtitle: 'Was there any accident?',
      children: [
        Row(
          children: [
            Expanded(
              child: _OptionCard(
                icon: CupertinoIcons.checkmark_shield_fill,
                label: 'No Accident',
                isSelected: isAccidentInvolved == false,
                onTap: () {
                  setState(() => isAccidentInvolved = false);
                  _nextPage();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _OptionCard(
                icon: CupertinoIcons.exclamationmark_triangle_fill,
                label: 'Accident',
                subtitle: '+50% Fine',
                isSelected: isAccidentInvolved == true,
                onTap: () {
                  setState(() => isAccidentInvolved = true);
                  Future.delayed(const Duration(milliseconds: 300), () {
                    _calculateAndNavigate();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepHeader(String step, String title, String subtitle) {
    Map<String, List<Color>> stepColors = {
      '1': [const Color(0xFF6D28D9), const Color(0xFF7C3AED)], // Purple
      '2': [const Color(0xFF0D9488), const Color(0xFF14B8A6)], // Teal
      '3': [const Color(0xFFDC2626), const Color(0xFFEF4444)], // Red
      '4': [const Color(0xFF1E40AF), const Color(0xFF3B82F6)], // Blue
    };

    final colors =
        stepColors[step] ?? [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors[0].withValues(alpha: 0.1),
                colors[1].withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'STEP $step OF 4',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: colors[0],
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkAccent,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.subtitleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionPage({
    required String step,
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(step, title, subtitle),
          const SizedBox(height: 48),
          ...children,
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  List<Color> _getCardColors() {
    // Determine color based on label
    if (label.contains('First') ||
        label.contains('Personal') ||
        label.contains('No')) {
      return [
        const Color(0xFF0D9488),
        const Color(0xFF14B8A6),
      ]; // Teal for positive
    } else {
      return [
        const Color(0xFFDC2626),
        const Color(0xFFEF4444),
      ]; // Red for modifiers
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getCardColors();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors[0] : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: isSelected ? Colors.white : colors[0]),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.darkAccent,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.8)
                      : AppTheme.subtitleColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
