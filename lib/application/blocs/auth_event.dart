abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String? errorMessage;

  SignUpSubmitted(this.email, this.password, this.errorMessage);
}

class SignUpCodeSubmitted extends SignUpEvent {
  final String email;
  final String code;

  SignUpCodeSubmitted(this.email, this.code);
}
 
class SignUpCodeResend extends SignUpEvent {
  final String email;

  SignUpCodeResend(this.email);
}
