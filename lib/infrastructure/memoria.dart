import 'dart:async';

import 'package:taller_fotos/domain/ficha.dart';

class FichaRepositorioMemoria implements FichaRepositorio {
  final List<Ficha> _items = [];
  final _controlador = StreamController<List<Ficha>>.broadcast();
  var _secuencia = 0;

  @override
  List<Ficha> get actuales => List.unmodifiable(_items);

  @override
  Stream<List<Ficha>> get cambios => _controlador.stream;

  @override
  Future<void> agregar(String titulo, Imagen imagen) async {
    final limpio = titulo.trim();
    if (limpio.isEmpty) throw ReglaDeFicha('La ficha necesita un título');
    if (imagen.bytes <= 0) throw ReglaDeFicha('La imagen está vacía');
    _secuencia += 1;
    _items.add(Ficha(id: 'f$_secuencia', titulo: limpio, imagen: imagen));
    _controlador.add(actuales);
  }

  @override
  Future<void> eliminar(String id) async {
    _items.removeWhere((ficha) => ficha.id == id);
    _controlador.add(actuales);
  }
}
