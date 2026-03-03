import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/violations') ||
        location.startsWith('/fine-details')) {
      return 1;
    }
    if (location.startsWith('/police-statement')) {
      return 3;
    }
    if (location.startsWith('/emergency-card')) {
      return 2;
    }
    if (location == '/') {
      return 0;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/violations');
        break;
      case 2:
        context.go('/emergency-card');
        break;
      case 3:
        context.go('/police-statement');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          child,
          // Floating Bottom Navigation Bar
          Positioned(
            bottom: 30,
            left: 32,
            right: 32,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.darkAccent,
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkAccent.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0, context),
                    child: _NavBarIcon(
                      icon: CupertinoIcons.home,
                      isSelected: currentIndex == 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(1, context),
                    child: _NavBarIcon(
                      icon: CupertinoIcons.doc_text,
                      isSelected: currentIndex == 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(2, context),
                    child: _NavBarIcon(
                      icon: CupertinoIcons.shield_lefthalf_fill,
                      isSelected: currentIndex == 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(3, context),
                    child: _NavBarIcon(
                      icon: CupertinoIcons.pen,
                      isSelected: currentIndex == 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const _NavBarIcon({required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isSelected
          ? BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(20),
            )
          : null,
      child: Icon(
        icon,
        color: isSelected ? AppTheme.darkAccent : Colors.white60,
        size: 24,
      ),
    );
  }
}
