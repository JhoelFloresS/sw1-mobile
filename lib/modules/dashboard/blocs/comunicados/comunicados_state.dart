// lib/blocs/comunicado/comunicado_state.dart

part of 'comunicados_bloc.dart';

abstract class ComunicadoState extends Equatable {
  const ComunicadoState();

  @override
  List<Object> get props => [];
}

class ComunicadoInitial extends ComunicadoState {}

class ComunicadoLoading extends ComunicadoState {}

class ComunicadoLoaded extends ComunicadoState {
  final List<Comunicado> comunicados;

  const ComunicadoLoaded({required this.comunicados});

  @override
  List<Object> get props => [comunicados];
}

class ComunicadoError extends ComunicadoState {
  final String error;

  const ComunicadoError({required this.error});

  @override
  List<Object> get props => [error];
}
