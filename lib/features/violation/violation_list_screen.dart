import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/violation_providers.dart';

class ViolationListScreen extends ConsumerWidget {
  const ViolationListScreen({super.key});

  IconData _getViolationIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('helmet')) return CupertinoIcons.shield_fill;
    if (t.contains('seatbelt')) return CupertinoIcons.car_detailed;
    if (t.contains('triple')) return CupertinoIcons.person_3_fill;
    if (t.contains('speed')) return CupertinoIcons.speedometer;
    if (t.contains('drink')) return CupertinoIcons.drop_fill;
    if (t.contains('rc')) return CupertinoIcons.doc_text_fill;
    if (t.contains('dl') || t.contains('license'))
      return CupertinoIcons.person_crop_rectangle_fill;
    if (t.contains('insurance')) return CupertinoIcons.checkmark_shield_fill;
    if (t.contains('wrong side'))
      return CupertinoIcons.arrow_right_arrow_left_square_fill;
    if (t.contains('mobile')) return CupertinoIcons.device_phone_portrait;
    if (t.contains('red light')) return CupertinoIcons.stop;
    if (t.contains('puc') || t.contains('pollution'))
      return CupertinoIcons.leaf_arrow_circlepath;
    return CupertinoIcons.exclamationmark_triangle_fill;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final violations = ref.watch(violationListProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        CupertinoIcons.back,
                        color: AppTheme.darkAccent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Violations & Fines',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkAccent,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 120,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: violations.length,
                itemBuilder: (context, index) {
                  final v = violations[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => context.push('/fine-details/$index'),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  _getViolationIcon(v.title),
                                  color: AppTheme.darkAccent,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      v.title,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppTheme.darkAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.warningColor.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '₹${v.fineFirst}',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.warningColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                CupertinoIcons.forward,
                                color: AppTheme.subtitleColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
