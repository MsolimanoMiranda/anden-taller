import 'package:flutter_test/flutter_test.dart';
import 'package:taller_fotos/domain/ficha.dart';
import 'package:taller_fotos/infrastructure/memoria.dart';
import 'package:taller_fotos/presentation/fichas_bloc.dart';

void main() {
  test('una imagen vacía no entra al stream', () async {
    final repo = FichaRepositorioMemoria();
    final bloc = FichasBloc(repo);
    addTearDown(bloc.close);

    final error = bloc.stream.firstWhere((estado) => estado.mensaje != null);
    bloc.add(const AgregarFicha('Retrato', Imagen(ruta: 'mem://1', bytes: 0)));
    final estado = await error;

    expect(estado.fichas, isEmpty);
    expect(estado.mensaje, 'La imagen está vacía');
  });

  test('agregar publica la ficha por el stream', () async {
    final repo = FichaRepositorioMemoria();
    final bloc = FichasBloc(repo);
    addTearDown(bloc.close);

    final lista = bloc.stream.firstWhere((estado) => estado.fichas.isNotEmpty);
    bloc.add(const AgregarFicha('Mercado', Imagen(ruta: 'mem://2', bytes: 40)));
    final estado = await lista;
    expect(estado.fichas.single.titulo, 'Mercado');
  });
}
