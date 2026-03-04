import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/violation.dart';

class FineCalculatorScreen extends StatefulWidget {
  const FineCalculatorScreen({super.key});

  @override
  State<FineCalculatorScreen> createState() => _FineCalculatorScreenState();
}

class _FineCalculatorScreenState extends State<FineCalculatorScreen> {
  Violation? selectedViolation;
  bool isFirstOffence = true;
  bool isCommercialVehicle = false;
  bool isAccidentInvolved = false;

  int calculateFine() {
    if (selectedViolation == null) return 0;

    int baseFine = isFirstOffence
        ? selectedViolation!.fineFirst
        : selectedViolation!.fineRepeat;

    // Commercial vehicle surcharge (25%)
    if (isCommercialVehicle) {
      baseFine = (baseFine * 1.25).toInt();
    }

    // Accident surcharge (50%)
    if (isAccidentInvolved) {
      baseFine = (baseFine * 1.5).toInt();
    }

    return baseFine;
  }

  @override
  Widget build(BuildContext context) {
    final calculatedFine = calculateFine();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            // Select Violation
            Text(
              '1. Select Violation',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkAccent,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: DropdownButton<Violation>(
                isExpanded: true,
                value: selectedViolation,
                hint: Text(
                  'Choose a violation...',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.subtitleColor,
                  ),
                ),
                underline: const SizedBox(),
                items: mockViolations.map((violation) {
                  return DropdownMenuItem(
                    value: violation,
                    child: Text(
                      violation.title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppTheme.darkAccent,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedViolation = value);
                },
              ),
            ),
            const SizedBox(height: 32),

            // First / Repeat Offence
            if (selectedViolation != null) ...[
              Text(
                '2. Offence Type',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkAccent,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _OffenceButton(
                      label: '1st Offence',
                      isSelected: isFirstOffence,
                      onTap: () => setState(() => isFirstOffence = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OffenceButton(
                      label: 'Repeat Offence',
                      isSelected: !isFirstOffence,
                      onTap: () => setState(() => isFirstOffence = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Commercial Vehicle
              Text(
                '3. Vehicle Type',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkAccent,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _OffenceButton(
                      label: 'Personal',
                      isSelected: !isCommercialVehicle,
                      onTap: () => setState(() => isCommercialVehicle = false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OffenceButton(
                      label: 'Commercial (+25%)',
                      isSelected: isCommercialVehicle,
                      onTap: () => setState(() => isCommercialVehicle = true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Accident Involved
              Text(
                '4. Accident Involved?',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkAccent,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _OffenceButton(
                      label: 'No',
                      isSelected: !isAccidentInvolved,
                      onTap: () => setState(() => isAccidentInvolved = false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OffenceButton(
                      label: 'Yes (+50%)',
                      isSelected: isAccidentInvolved,
                      onTap: () => setState(() => isAccidentInvolved = true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Fine Calculation Result
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your Fine Amount',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkAccent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '₹$calculatedFine',
                      style: GoogleFonts.inter(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkAccent,
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        selectedViolation!.title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Additional Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Important Information',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkAccent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      label: 'License Seizable',
                      value: selectedViolation!.licenseSeizable
                          ? '✓ Yes'
                          : '✗ No',
                      valueColor: selectedViolation!.licenseSeizable
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF10B981),
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      label: 'Vehicle Seizable',
                      value: selectedViolation!.vehicleSeizable
                          ? '✓ Yes'
                          : '✗ No',
                      valueColor: selectedViolation!.vehicleSeizable
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF10B981),
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      label: 'Receipt Required',
                      value: selectedViolation!.receiptMandatory
                          ? '✓ Yes'
                          : '✗ No',
                      valueColor: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      label: 'Cash Payment Allowed',
                      value: selectedViolation!.cashAllowed ? '✓ Yes' : '✗ No',
                      valueColor: selectedViolation!.cashAllowed
                          ? const Color(0xFF10B981)
                          : AppTheme.subtitleColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ] else
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5B800)),
                ),
                child: Column(
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_circle,
                      size: 32,
                      color: Color(0xFFD97706),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Select a violation to calculate fine',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _OffenceButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OffenceButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppTheme.darkAccent : AppTheme.darkAccent,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.subtitleColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
