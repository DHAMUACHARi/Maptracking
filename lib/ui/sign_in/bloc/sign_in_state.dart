enum Status { processing, data, success, error }

class SignInState {
  final Status status;
  final String email;
  final String password;
  final String? emailValidation;
  final String? passwordValidation;
  final String? errorValidation;

  SignInState({
    required this.status,
    this.email = '',
    this.password = '',
    this.emailValidation,
    this.passwordValidation,
    this.errorValidation,
  });

  SignInState copyWith({
    Status? status,
    String? email,
    String? password,
    String? emailValidation,
    String? passwordValidation,
    String? errorValidation,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      emailValidation: emailValidation ?? this.emailValidation,
      passwordValidation: passwordValidation ?? this.passwordValidation,
      errorValidation: errorValidation ?? this.errorValidation,
    );
  }
}

