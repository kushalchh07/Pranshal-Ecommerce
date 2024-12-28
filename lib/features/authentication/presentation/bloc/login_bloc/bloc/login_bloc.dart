import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/authentication_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final response =
            await authRepository.login(event.email, event.password);
        emit(LoginSuccess(response: response));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
