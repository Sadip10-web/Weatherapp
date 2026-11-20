import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/main.dart';

void main() {
  testWidgets('shows the branded splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('AERIS'), findsOneWidget);
    expect(find.text('Your weather, beautifully clear'), findsOneWidget);
  });
}
