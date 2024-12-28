import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/authentication_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final response = await authRepository.register(
          event.username,
          event.email,
          event.password,
          event.phoneNumber,
        );
        emit(RegisterSuccess(response: response));
      } catch (e) {
        emit(RegisterFailure(error: e.toString()));
      }
    });
  }
}
