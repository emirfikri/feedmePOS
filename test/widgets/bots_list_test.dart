import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcd_bot/domain/entities/export_entities.dart';
import 'package:mcd_bot/presentation/pages/home/home_widgets/export_home_widgets.dart';

void main() {
  testWidgets("BotsList shows correct busy/idle bots", (tester) async {
    final inProgress = [
      InProgress(
        botId: 1,
        order: Order(
          id: 100,
          type: OrderType.normal,
          status: OrderStatus.processing,
        ),
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(seconds: 10)),
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BotsList(
            inProgress: inProgress,
            bots: [
              Bots(id: 1, isFast: false),
              Bots(id: 2, isFast: false),
              Bots(id: 3, isFast: false),
            ],
          ),
        ),
      ),
    );

    // Busy bot should appear
    expect(find.text("Processing Order #100"), findsOneWidget);

    // Idle bots count = 2
    expect(find.text("Available"), findsNWidgets(2));

    // Bot labels
    expect(find.text("B1"), findsOneWidget);
    expect(find.text("B2"), findsOneWidget);
    expect(find.text("B3"), findsOneWidget);
  });
}
