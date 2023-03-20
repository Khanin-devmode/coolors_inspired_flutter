import 'package:coolors_inspired_flutter/features/generate_palette/presentation/generate_palette_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:coolors_inspired_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('open menu, tap add color, check new color', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // // Verify the counter starts at 0.
      // expect(find.text('0'), findsOneWidget);

      // // Finds the floating action button to tap on.
      // final Finder fab = find.byTooltip('Increment');

      // // Emulate a tap on the floating action button.
      // await tester.tap(fab);

      // // Trigger a frame.
      // await tester.pumpAndSettle();

      // // Verify the counter increments by 1.
      // expect(find.text('1'), findsOneWidget);

      //open menu
      final colorRow = find.byKey(Key('COLOR_ROW_0'));
      await tester.tap(colorRow);

      await tester.pumpAndSettle();

      final addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.byType(ColorRow), findsNWidgets(6));

      //select add color
      //expect 1 more color
    });
  });
}
