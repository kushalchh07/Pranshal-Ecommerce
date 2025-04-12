import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pranshal_ecommerce/core/constants/user_data.dart';
import '../../../../../../core/constants/colors.dart';
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
        if (response['status'] == true) {
          userId = response['user']['user_id'];
          userName = response['user']['fullname'];
          userEmail = response['user']['email_address'];
          userPhoneNumber = response['user']['contact_number'];
          userImage = response['user']['profile_image'];
          Fluttertoast.showToast(
            msg: 'Login Successful',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: whiteColor,
          );
          emit(LoginSuccess(response: response));
        } else {
          emit(LoginFailure(error: response['message']));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
