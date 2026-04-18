import 'package:flutter_test/flutter_test.dart';
import 'package:medical_directory/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(const MedicalApp());


    expect(find.text('Medical Directory Mila'), findsOneWidget);
  });
}