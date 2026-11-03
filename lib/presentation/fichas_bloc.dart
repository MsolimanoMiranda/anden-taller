import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taller_fotos/domain/ficha.dart';

sealed class FichasEvent extends Equatable {
  const FichasEvent();
  @override
  List<Object?> get props => [];
}

class AgregarFicha extends FichasEvent {
  const AgregarFicha(this.titulo, this.imagen);
  final String titulo;
  final Imagen imagen;
  @override
  List<Object?> get props => [titulo, imagen.ruta, imagen.bytes];
}

class ListaNueva extends FichasEvent {
  const ListaNueva(this.fichas);
  final List<Ficha> fichas;
  @override
  List<Object?> get props => [fichas];
}

class FichasListas extends Equatable {
  const FichasListas(this.fichas, {this.mensaje});
  final List<Ficha> fichas;
  final String? mensaje;
  @override
  List<Object?> get props => [fichas, mensaje];
}

class FichasBloc extends Bloc<FichasEvent, FichasListas> {
  FichasBloc(this._repo) : super(FichasListas(_repo.actuales)) {
    on<AgregarFicha>(_agregar);
    on<ListaNueva>((event, emit) => emit(FichasListas(event.fichas)));
    _sub = _repo.cambios.listen((lista) => add(ListaNueva(lista)));
  }

  final FichaRepositorio _repo;
  late final StreamSubscription<List<Ficha>> _sub;

  Future<void> _agregar(AgregarFicha event, Emitter<FichasListas> emit) async {
    try {
      await _repo.agregar(event.titulo, event.imagen);
    } on ReglaDeFicha catch (error) {
      emit(FichasListas(_repo.actuales, mensaje: error.mensaje));
    }
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}
