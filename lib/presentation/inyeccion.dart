import 'package:get_it/get_it.dart';
import 'package:taller_fotos/domain/ficha.dart';
import 'package:taller_fotos/infrastructure/memoria.dart';

final getIt = GetIt.instance;

void configurarDependencias() {
  if (getIt.isRegistered<FichaRepositorio>()) return;
  getIt.registerSingleton<FichaRepositorio>(FichaRepositorioMemoria());
}
