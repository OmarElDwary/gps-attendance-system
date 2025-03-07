import 'package:flutter_test/flutter_test.dart';
import 'package:gps_attendance_system/app/app.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/admin_home.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(AdminHome), findsOneWidget);
    });
  });
}
