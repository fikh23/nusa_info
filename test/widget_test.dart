import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_info/main.dart';

void main() {
  testWidgets('NusaInfo app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NusaInfoApp());

    expect(find.text('NusaInfo'), findsOneWidget);
  });
}
