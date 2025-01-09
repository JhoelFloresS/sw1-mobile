// lib/blocs/comunicado/comunicado_event.dart

part of 'comunicados_bloc.dart';

abstract class ComunicadoEvent extends Equatable {
  const ComunicadoEvent();

  @override
  List<Object> get props => [];
}

class FetchComunicadosEvent extends ComunicadoEvent {
  final String fecha;

  const FetchComunicadosEvent({required this.fecha});

  @override
  List<Object> get props => [fecha];
}
