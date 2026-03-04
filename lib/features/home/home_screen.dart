import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              physics: const BouncingScrollPhysics(),
              children: [
                // Header Profile Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.appName,
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkAccent,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Updated as per Motor Vehicle Act 2019',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.subtitleColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        '🌐 EN | हिंदी',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Primary Action: Scan/Check Challan
                InkWell(
                  onTap: () => context.push('/violations'),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D5FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Check Traffic Fine',
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.5,
                                  color: AppTheme.darkAccent,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Know the correct fine amount instantly',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(
                              alpha: 0.15,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            CupertinoIcons.doc_text_search,
                            size: 28,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Urgent / Tool Actions Grid
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () => context.push('/emergency-card'),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.warningColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                CupertinoIcons.hand_raised_fill,
                                size: 32,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Stopped by\nPolice?',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to know your rights instantly',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => context.push('/police-statement'),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Report',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.darkAccent,
                                        ),
                                      ),
                                      const Icon(
                                        CupertinoIcons.doc_plaintext,
                                        size: 20,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Statement',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () => context.push('/fine-calculator'),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFEAFE),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFC7D2FE),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Calculate',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1E40AF),
                                        ),
                                      ),
                                      const Icon(
                                        CupertinoIcons.chart_bar_fill,
                                        size: 20,
                                        color: const Color(0xFF1E40AF),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Your fine',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Common Violations Horizontal Scroll
                Text(
                  'Common Violations',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkAccent,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      const _ViolationChip(
                        title: 'Helmet',
                        icon: CupertinoIcons.shield,
                      ),
                      const SizedBox(width: 8),
                      const _ViolationChip(
                        title: 'Seatbelt',
                        icon: CupertinoIcons.car_detailed,
                      ),
                      const SizedBox(width: 8),
                      const _ViolationChip(
                        title: 'Mobile Use',
                        icon: CupertinoIcons.device_phone_portrait,
                      ),
                      const SizedBox(width: 8),
                      const _ViolationChip(
                        title: 'Drink & Drive',
                        icon: CupertinoIcons.drop,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Information Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA7F3D0),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.info_circle_fill,
                              size: 20,
                              color: Color(0xFF059669),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Did You Know?',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF059669),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'You have the right to see a written copy of the traffic ticket',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF065F46),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // FAQ Section
                Text(
                  'Frequently Asked Questions',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkAccent,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _FAQItem(
                        question: 'What if I disagree with the fine?',
                        answer:
                            'You can appeal within 30 days at traffic court',
                      ),
                      Divider(color: Colors.grey.shade200),
                      _FAQItem(
                        question: 'Can I pay online?',
                        answer:
                            'Yes, most fines can be paid through official traffic portals',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32), // Bottom padding
              ],
            ),
          ),

          // Navigation bar is now handled by ShellRoute in app_scaffold.dart
        ],
      ),
    );
  }
}

class _ViolationChip extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ViolationChip({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkAccent,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  size: 18,
                  color: AppTheme.subtitleColor,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                widget.answer,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.subtitleColor,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
