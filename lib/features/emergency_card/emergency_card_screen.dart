import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class EmergencyCardScreen extends StatelessWidget {
  const EmergencyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Rights'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.shield_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Emergency Rights Card',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Show this to the officer',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rights cards
            Expanded(
              child: ListView(
                children: const [
                  _RightCard(
                    number: '1',
                    text: 'I want an official challan receipt.',
                    hindi: 'Mujhe official challan receipt chahiye.',
                  ),
                  SizedBox(height: 12),
                  _RightCard(
                    number: '2',
                    text: 'Please issue challan as per law.',
                    hindi: 'Kripya kanoon ke anusaar challan kaatein.',
                  ),
                  SizedBox(height: 12),
                  _RightCard(
                    number: '3',
                    text: 'Cash payment without receipt is not acceptable.',
                    hindi: 'Bina receipt ke cash payment manzoor nahi hai.',
                  ),
                  SizedBox(height: 12),
                  _RightCard(
                    number: '4',
                    text: 'I have the right to know the exact violation.',
                    hindi:
                        'Mujhe ye jaanne ka adhikaar hai ki mera violation kya hai.',
                  ),
                  SizedBox(height: 12),
                  _RightCard(
                    number: '5',
                    text: 'I can pay the fine online within the given time.',
                    hindi: 'Main fine online bhi bhuktan kar sakta/sakti hoon.',
                  ),
                ],
              ),
            ),

            // Footer
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.successColor.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.offline_bolt_outlined,
                    color: AppTheme.successColor,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Works offline — no internet needed',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.successColor,
                      ),
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

class _RightCard extends StatelessWidget {
  final String number;
  final String text;
  final String hindi;

  const _RightCard({
    required this.number,
    required this.text,
    required this.hindi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  hindi,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.subtitleColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
