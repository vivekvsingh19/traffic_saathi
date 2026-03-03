import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class _PoliceStatement {
  final String statement;
  final String status; // 'allowed', 'not_allowed', 'conditional'
  final String explanation;

  const _PoliceStatement({
    required this.statement,
    required this.status,
    required this.explanation,
  });
}

const _statements = [
  _PoliceStatement(
    statement: '"License le lenge"',
    status: 'conditional',
    explanation:
        'Sirf kuch violations mein license seize ho sakta hai — jaise over speeding, drink & drive, wrong side driving. Har violation mein nahi le sakte.',
  ),
  _PoliceStatement(
    statement: '"Cash de do"',
    status: 'not_allowed',
    explanation:
        'Cash mein fine lena illegal hai. Fine sirf official challan receipt ke through hona chahiye. Bina receipt ke paisa lena rishwat hai.',
  ),
  _PoliceStatement(
    statement: '"Gaadi seize hogi"',
    status: 'conditional',
    explanation:
        'Sirf kuch cases mein gaadi seize ho sakti hai — jaise No DL, No RC, No Insurance, Drink & Drive. Har offence mein gaadi seize nahi hoti.',
  ),
  _PoliceStatement(
    statement: '"Abhi fine bharo nahi toh jail"',
    status: 'not_allowed',
    explanation:
        'Traffic violation ke liye seedha jail nahi ho sakti (sirf Drink & Drive mein ho sakti hai). Aapko court mein pesh hone ka mauka milta hai.',
  ),
  _PoliceStatement(
    statement: '"Receipt ki zaroorat nahi"',
    status: 'not_allowed',
    explanation:
        'Har fine ke liye official receipt dena zaroori hai. Bina receipt ke challan invalid hai. Aap receipt maang sakte hain — ye aapka legal right hai.',
  ),
  _PoliceStatement(
    statement: '"Challan online aa jayega"',
    status: 'allowed',
    explanation:
        'Agar CCTV ya traffic camera se violation detect hota hai toh online e-challan aata hai. Ye bilkul legal process hai.',
  ),
];

class PoliceStatementScreen extends StatelessWidget {
  const PoliceStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Police Said This?'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _statements.length,
        itemBuilder: (context, index) {
          final s = _statements[index];
          return _StatementCard(statement: s);
        },
      ),
    );
  }
}

class _StatementCard extends StatelessWidget {
  final _PoliceStatement statement;

  const _StatementCard({required this.statement});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    String badgeText;
    IconData badgeIcon;

    switch (statement.status) {
      case 'allowed':
        badgeColor = AppTheme.successColor;
        badgeText = 'Legal';
        badgeIcon = Icons.check_circle_outline;
      case 'not_allowed':
        badgeColor = AppTheme.warningColor;
        badgeText = 'Not Allowed';
        badgeIcon = Icons.cancel_outlined;
      default:
        badgeColor = const Color(0xFFE65100);
        badgeText = 'Conditional';
        badgeIcon = Icons.info_outline;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    statement.statement,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(badgeIcon, size: 14, color: badgeColor),
                      const SizedBox(width: 4),
                      Text(
                        badgeText,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: badgeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              statement.explanation,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
