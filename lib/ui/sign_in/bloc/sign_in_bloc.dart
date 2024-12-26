import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_maps/ui/sign_in/bloc/sign_in_event.dart';
import 'package:real_time_maps/ui/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState(status: Status.data,email: 'test@example.com',password: '123456')) {
    on<EmailInputEvent>(onEmailInput);
    on<PasswordInputEvent>(onPasswordInput);
    on<SignInSubmittedEvent>(onSignInSubmitted);
  }

  void onSignInSubmitted(event, emit) {
    // Check if the email is empty
    if (state.email.isEmpty) {
      emit(state.copyWith(
        status: Status.data,
        emailValidation: "Email must not be empty.",
      ));
      return; // Stop further validation if email is empty
    }

    // Validate email format (simple validation)
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(state.email)) {
      emit(state.copyWith(
        status: Status.data,
        emailValidation: "Please enter a valid email address.",
      ));
      return;
    }

    // Check if the password is empty
    if (state.password.isEmpty) {
      emit(state.copyWith(
        status: Status.data,
        passwordValidation: "Password must not be empty.",
      ));
      return;
    }

    // Validate password length
    if (state.password.length < 6) {
      emit(state.copyWith(
        status: Status.data,
        passwordValidation: "Password must be at least 6 characters long.",
      ));
      return;
    }
    emit(state.copyWith(status: Status.processing));
    // Successful login simulation
    if (state.email == "test@example.com" && state.password == "123456") {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(
        status: Status.error,
        errorValidation: "Invalid email or password.",
      ));
    }
  }


  void onEmailInput(EmailInputEvent event, emit) {
    emit(state.copyWith(email: event.email,emailValidation: null,));
  }

  void onPasswordInput(PasswordInputEvent event, emit) {
    emit(state.copyWith(password: event.password,passwordValidation: null));
  }
}
