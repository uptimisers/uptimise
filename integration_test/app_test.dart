import 'package:uptimise/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App', () {
    testWidgets('SignInPage is rendered', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Start Uptimising'), findsOneWidget);
    });
  });
}
