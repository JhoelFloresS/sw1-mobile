// comunicados_bloc.dart

import 'package:agenda_mobile/modules/auth/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agenda_mobile/data/models/comunicados.dart';
import 'package:agenda_mobile/data/services/comunicado_service.dart';
import 'package:equatable/equatable.dart';

part 'comunicados_event.dart';
part 'comunicados_state.dart';

class ComunicadoBloc extends Bloc<ComunicadoEvent, ComunicadoState> {
  final ComunicadoService comunicadoService;
  final AuthBloc authBloc;
  // Constructor
  ComunicadoBloc({required this.comunicadoService, required this.authBloc})
      : super(ComunicadoInitial()) {
    // Registrar el manejador para FetchComunicadosEvent
    on<FetchComunicadosEvent>(_onFetchComunicados);
  }

  // Manejador del evento FetchComunicadosEvent
  Future<void> _onFetchComunicados(
      FetchComunicadosEvent event, Emitter<ComunicadoState> emit) async {
    emit(ComunicadoLoading());

    try {
      // Obtener el token desde el AuthBloc
      if( authBloc.state is Authenticated){
        final token = (authBloc.state as Authenticated).session.token;
        if (token != null) {
          // Pasar el token al servicio
          final comunicados =
              await comunicadoService.fetchComunicados(event.fecha, token);
          emit(ComunicadoLoaded(comunicados: comunicados));
        } else {
          throw Exception('Token no disponible');
        }
      }

    } catch (e) {
      emit(ComunicadoError(error: e.toString()));
    }
  }
}
