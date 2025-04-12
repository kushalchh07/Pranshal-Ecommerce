import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/user_data.dart';
import '../../../../data/repositories/authentication_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final response = await authRepository.register(event.username,
            event.email, event.password, event.phoneNumber, event.otp);
        if (response["status"] == true) {
          Fluttertoast.showToast(
            msg: 'Registered Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: whiteColor,
          );
          userId = response['user']['user_id'];
          userName = response['user']['fullname'];
          userEmail = response['user']['email_address'];
          userPhoneNumber = response['user']['contact_number'];
          userImage = response['user']['profile_image'];
          emit(RegisterSuccess(response: response));
        } else {
          emit(RegisterFailure(error: response["message"]));
        }
      } catch (e) {
        emit(RegisterFailure(error: e.toString()));
      }
    });
  }
}
