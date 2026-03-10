import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../models/violation.dart';

class FineResultScreen extends StatelessWidget {
  final Violation violation;
  final int totalFine;
  final bool isFirstOffence;
  final bool isCommercialVehicle;
  final bool isAccidentInvolved;

  const FineResultScreen({
    super.key,
    required this.violation,
    required this.totalFine,
    required this.isFirstOffence,
    required this.isCommercialVehicle,
    required this.isAccidentInvolved,
  });

  List<Color> _getGradientColor() {
    // Use different gradients based on violation type
    if (violation.title.contains('Helmet') ||
        violation.title.contains('Seatbelt')) {
      return [const Color(0xFF6D28D9), const Color(0xFF7C3AED)]; // Purple
    } else if (violation.title.contains('Speeding') ||
        violation.title.contains('Speed')) {
      return [const Color(0xFFDC2626), const Color(0xFFEF4444)]; // Red
    } else if (violation.title.contains('Drink') ||
        violation.title.contains('DUI')) {
      return [const Color(0xFFF59E0B), const Color(0xFFFCD34D)]; // Amber
    } else {
      return [const Color(0xFF1E40AF), const Color(0xFF3B82F6)]; // Blue
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppTheme.darkAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Fine Calculation',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            // Fine Amount Card
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_getGradientColor()[0], _getGradientColor()[1]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: _getGradientColor()[0].withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.money_dollar_circle_fill,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Total Fine Amount',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '₹$totalFine',
                    style: GoogleFonts.inter(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      violation.title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Breakdown Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _getGradientColor()[0].withValues(alpha: 0.05),
                    _getGradientColor()[1].withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getGradientColor()[0].withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fine Breakdown',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _getGradientColor()[0],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _BreakdownRow(
                    label: 'Base Fine',
                    value:
                        '₹${isFirstOffence ? violation.fineFirst : violation.fineRepeat}',
                    icon: CupertinoIcons.doc_text_fill,
                  ),
                  if (isCommercialVehicle) ...[
                    const SizedBox(height: 12),
                    _BreakdownRow(
                      label: 'Commercial Vehicle',
                      value: '+25%',
                      icon: CupertinoIcons.bus,
                      isAddition: true,
                    ),
                  ],
                  if (isAccidentInvolved) ...[
                    const SizedBox(height: 12),
                    _BreakdownRow(
                      label: 'Accident Involved',
                      value: '+50%',
                      icon: CupertinoIcons.exclamationmark_triangle_fill,
                      isAddition: true,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Divider(color: _getGradientColor()[0].withValues(alpha: 0.2)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _getGradientColor()[0],
                        ),
                      ),
                      Text(
                        '₹$totalFine',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E3A8A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Important Information Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFEAFE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          CupertinoIcons.info_circle_fill,
                          size: 20,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Important Information',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.darkAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    label: 'License Seizable',
                    value: violation.licenseSeizable ? 'Yes' : 'No',
                    valueColor: violation.licenseSeizable
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981),
                    icon: violation.licenseSeizable
                        ? CupertinoIcons.xmark_circle_fill
                        : CupertinoIcons.checkmark_circle_fill,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'Vehicle Seizable',
                    value: violation.vehicleSeizable ? 'Yes' : 'No',
                    valueColor: violation.vehicleSeizable
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981),
                    icon: violation.vehicleSeizable
                        ? CupertinoIcons.xmark_circle_fill
                        : CupertinoIcons.checkmark_circle_fill,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'Receipt Required',
                    value: violation.receiptMandatory ? 'Yes' : 'No',
                    valueColor: const Color(0xFF1E3A8A),
                    icon: CupertinoIcons.doc_text_fill,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'Cash Payment',
                    value: violation.cashAllowed ? 'Allowed' : 'Not Allowed',
                    valueColor: violation.cashAllowed
                        ? const Color(0xFF10B981)
                        : AppTheme.subtitleColor,
                    icon: violation.cashAllowed
                        ? CupertinoIcons.money_dollar_circle_fill
                        : CupertinoIcons.slash_circle_fill,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isAddition;

  const _BreakdownRow({
    required this.label,
    required this.value,
    required this.icon,
    this.isAddition = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                (isAddition ? const Color(0xFFDC2626) : const Color(0xFF1E3A8A))
                    .withValues(alpha: 0.1),
                (isAddition ? const Color(0xFFEF4444) : const Color(0xFF3B82F6))
                    .withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: isAddition
                ? const Color(0xFFDC2626)
                : const Color(0xFF1E40AF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkAccent,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isAddition ? const Color(0xFFDC2626) : AppTheme.darkAccent,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final IconData icon;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.subtitleColor,
          ),
        ),
        Row(
          children: [
            Icon(icon, size: 16, color: valueColor),
            const SizedBox(width: 6),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
