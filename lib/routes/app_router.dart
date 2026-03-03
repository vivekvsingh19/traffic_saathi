import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/violation/violation_list_screen.dart';
import '../features/fine_details/fine_details_screen.dart';
import '../features/police_statement/police_statement_screen.dart';
import '../features/emergency_card/emergency_card_screen.dart';
import 'app_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/violations',
          builder: (context, state) => const ViolationListScreen(),
        ),
        GoRoute(
          path: '/fine-details/:index',
          builder: (context, state) {
            final index = int.parse(state.pathParameters['index'] ?? '0');
            return FineDetailsScreen(violationIndex: index);
          },
        ),
        GoRoute(
          path: '/police-statement',
          builder: (context, state) => const PoliceStatementScreen(),
        ),
        GoRoute(
          path: '/emergency-card',
          builder: (context, state) => const EmergencyCardScreen(),
        ),
      ],
    ),
  ],
);
