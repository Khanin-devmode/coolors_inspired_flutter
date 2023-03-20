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

      //open menu
      final colorRow = find.byKey(Key('COLOR_ROW_0'));
      await tester.tap(colorRow);
      await tester.pumpAndSettle();

      //select add color
      final addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      //expect 1 more color
      expect(find.byType(ColorRow), findsNWidgets(6));
    });
  });
}
