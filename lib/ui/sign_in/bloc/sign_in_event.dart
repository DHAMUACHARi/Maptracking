abstract class SignInEvent{}

final class EmailInputEvent extends SignInEvent {
  final String email;
  EmailInputEvent({required this.email});
  @override
  List<Object> get props => [email];
}

final class PasswordInputEvent extends SignInEvent {
  final String password;
  PasswordInputEvent({required this.password});
  @override
  List<Object> get props => [password];
}
final class SignInSubmittedEvent extends SignInEvent {

  SignInSubmittedEvent();
  @override
  List<Object> get props => [];
}