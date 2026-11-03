import 'package:flutter_test/flutter_test.dart';
import 'package:taller_fotos/main.dart';
import 'package:taller_fotos/presentation/inyeccion.dart';

void main() {
  testWidgets('el taller abre vacío', (tester) async {
    await getIt.reset();
    configurarDependencias();
    await tester.pumpWidget(const TallerApp());
    expect(find.text('Taller de fotos'), findsOneWidget);
    expect(find.text('Todavía no hay fichas.'), findsOneWidget);
  });
}
