part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object?> get props => [token];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object?> get props => [];
}
