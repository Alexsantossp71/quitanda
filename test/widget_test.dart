import 'package:flutter_test/flutter_test.dart';

import 'package:greengrocery/main.dart';

void main() {
  testWidgets('app inicia sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(tester.takeException(), isNull);
  });
}
