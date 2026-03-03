import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/violation.dart';
import '../data/mock_data.dart';

/// Provides the full list of violations
final violationListProvider = Provider<List<Violation>>((ref) {
  return mockViolations;
});

/// Tracks the currently selected violation index
final selectedViolationIndexProvider = StateProvider<int>((ref) => 0);
