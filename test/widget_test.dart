import 'package:flutter_test/flutter_test.dart';
import 'package:traffic_saathi/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TrafficSaathiApp());
    expect(find.text('Traffic Saathi'), findsOneWidget);
  });
}
