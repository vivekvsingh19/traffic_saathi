import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/violation_providers.dart';

class FineDetailsScreen extends ConsumerWidget {
  final int violationIndex;

  const FineDetailsScreen({super.key, required this.violationIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final violations = ref.watch(violationListProvider);
    final violation = violations[violationIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fine Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/police-statement'),
            icon: const Icon(Icons.gavel_rounded, size: 18),
            label: const Text('Know Rights'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.warningColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        color: AppTheme.warningColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        violation.title,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Fine amounts
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _FineRow(
                      label: 'First Offence',
                      amount: '₹${violation.fineFirst}',
                      color: const Color(0xFFE65100),
                    ),
                    const Divider(height: 24),
                    _FineRow(
                      label: 'Repeat Offence',
                      amount: '₹${violation.fineRepeat}',
                      color: AppTheme.warningColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Status badges
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _StatusRow(
                      label: 'License Seizable?',
                      value: violation.licenseSeizable,
                    ),
                    const SizedBox(height: 16),
                    _StatusRow(
                      label: 'Vehicle Seizable?',
                      value: violation.vehicleSeizable,
                    ),
                    const SizedBox(height: 16),
                    _StatusRow(
                      label: 'Receipt Mandatory?',
                      value: violation.receiptMandatory,
                      invertColor: true,
                    ),
                    const SizedBox(height: 16),
                    _StatusRow(
                      label: 'Cash Allowed?',
                      value: violation.cashAllowed,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Explanation
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explanation',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      violation.simpleExplanation,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FineRow extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const _FineRow({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 15, color: AppTheme.subtitleColor),
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final bool value;
  final bool invertColor;

  const _StatusRow({
    required this.label,
    required this.value,
    this.invertColor = false,
  });

  @override
  Widget build(BuildContext context) {
    // For receipt mandatory — true is green (good), false is red
    // For license/vehicle seizable — true is red (bad), false is green
    // For cash allowed — true is green, false is red
    final isPositive = invertColor ? value : !value;
    final bgColor = isPositive
        ? AppTheme.successColor.withValues(alpha: 0.1)
        : AppTheme.warningColor.withValues(alpha: 0.1);
    final textColor = isPositive
        ? AppTheme.successColor
        : AppTheme.warningColor;
    final statusText = value ? 'Yes' : 'No';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 15, color: Colors.grey.shade700),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            statusText,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
