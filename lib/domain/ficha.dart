class ReglaDeFicha implements Exception {
  ReglaDeFicha(this.mensaje);
  final String mensaje;
  @override
  String toString() => mensaje;
}

class Imagen {
  const Imagen({required this.ruta, required this.bytes});
  final String ruta;
  final int bytes;
}

class Ficha {
  const Ficha({required this.id, required this.titulo, required this.imagen});
  final String id;
  final String titulo;
  final Imagen imagen;
}

abstract class FichaRepositorio {
  List<Ficha> get actuales;
  Stream<List<Ficha>> get cambios;
  Future<void> agregar(String titulo, Imagen imagen);
  Future<void> eliminar(String id);
}
