// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mcd_bot/data/repository/in_memory_repository.dart';

import 'package:mcd_bot/main.dart';

class MockRepository extends InMemoryRepository {}

void main() {
  testWidgets('New Normal Order test will find one order Order#1', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(repo: MockRepository()));

    // Verify that our counter starts at 0.
    expect(find.text('New Normal Order'), findsOneWidget);
    // expect(find.text('New Normal Order'), findsNothing);

    // Tap the '+' add Normal Order.
    await tester.tap(find.text('New Normal Order'));
    await tester.pump();
    expect(find.text('Order #1'), findsOneWidget);
  });

  testWidgets('+ Bot will absorb the order and remove from ui', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(repo: MockRepository()));

    await tester.tap(find.text('New Normal Order'));
    await tester.pump();

    await tester.tap(find.text('Add Bot'));
    await tester.pump();

    expect(find.text('Order #1'), findsNothing);

    // Clear pending timers
    await tester.pump(const Duration(seconds: 11));
  });
}
