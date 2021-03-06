import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jpec_base/authentication/authentication_bloc.dart';
import 'package:jpec_base/repositories/base_user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BaseUserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  final String loginUrl;

  LoginBloc(
      {required this.userRepository,
      required this.authenticationBloc,
      required this.loginUrl})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.login(
            username: event.username,
            password: event.password,
            url: this.loginUrl);
        if (token == null) {
          yield LoginFailure(error: "An error occurred.");
        }

        authenticationBloc.add(LoggedIn(token: token!));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
