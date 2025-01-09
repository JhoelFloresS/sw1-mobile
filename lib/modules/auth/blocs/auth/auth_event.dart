part of 'auth_bloc.dart';



abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends AuthEvent {}
