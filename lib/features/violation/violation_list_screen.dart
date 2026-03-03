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
    if (t.contains('helmet')) return Icons.sports_motorsports_outlined;
    if (t.contains('seatbelt')) return Icons.airline_seat_recline_normal;
    if (t.contains('triple')) return Icons.people_outline;
    if (t.contains('speed')) return Icons.speed;
    if (t.contains('drink')) return Icons.local_bar_outlined;
    if (t.contains('rc')) return Icons.description_outlined;
    if (t.contains('dl') || t.contains('license')) return Icons.badge_outlined;
    if (t.contains('insurance')) return Icons.security_outlined;
    if (t.contains('wrong side')) return Icons.swap_horiz;
    if (t.contains('mobile')) return Icons.phone_android;
    if (t.contains('red light')) return Icons.traffic_outlined;
    if (t.contains('puc') || t.contains('pollution')) return Icons.eco_outlined;
    return Icons.warning_amber_rounded;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final violations = ref.watch(violationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic Violations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: violations.length,
        itemBuilder: (context, index) {
          final v = violations[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getViolationIcon(v.title),
                  color: AppTheme.primaryColor,
                  size: 22,
                ),
              ),
              title: Text(
                v.title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '₹${v.fineFirst} fine',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppTheme.subtitleColor,
                  ),
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.subtitleColor,
              ),
              onTap: () => context.push('/fine-details/$index'),
            ),
          );
        },
      ),
    );
  }
}
