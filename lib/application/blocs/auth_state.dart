// Enum для статусов
enum SignUpStatus {
  initial,
  loading,
  success,
  failure,
  validationError,
  codePending,
  codeVerifying,
  codeVerified,
  codeResending,
  completed,
}

class SignUpState {
  final SignUpStatus status;
  final String errorMessage;
  final String? email;
  final String? successMessage;

  const SignUpState({
    this.status = SignUpStatus.initial,
    this.errorMessage = '',
    this.email,
    this.successMessage,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
    String? email,
    String? successMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  bool get isLoading => status == SignUpStatus.loading;
  bool get isCodePending => status == SignUpStatus.codePending;
  bool get isCodeVerifying => status == SignUpStatus.codeVerifying;
  bool get isCodeResending => status == SignUpStatus.codeResending;
}
