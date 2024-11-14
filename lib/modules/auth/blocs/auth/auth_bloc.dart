import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthInitial()) {

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        // Simula una llamada a un servicio o API para autenticar al usuario
        final bool isAuthenticated = await _authenticateUser(event.email, event.password);

        if (isAuthenticated) {
          // Si la autenticación es exitosa, emitir estado de éxito
          emit(AuthSuccess()); // Aquí deberías pasar el userId real o el dato correspondiente
        } else {
          // Si la autenticación falla, emitir estado de fallo con mensaje de error
          emit(AuthFailure(error: 'Invalid email or password'));
        }
      } catch (e) {
        // Si hay un error inesperado, emitir estado de fallo con un mensaje de error
        emit(AuthFailure(error: e.toString()));
      }
    });

  }

    Future<bool> _authenticateUser(String email, String password) async {
    // Lógica de autenticación que conecte con el repositorio o servicio
    return email == "test@example.com" && password == "password";
  }

}
