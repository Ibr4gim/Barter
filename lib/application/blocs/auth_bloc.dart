// import 'package:Barter/application/blocs/auth_event.dart';
// import 'package:Barter/application/blocs/auth_state.dart';
import 'package:BirJol/application/blocs/auth_event.dart';
import 'package:BirJol/application/blocs/auth_state.dart';
import 'package:bloc/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignUpCodeSubmitted>(_onSignUpCodeSubmitted);
    on<SignUpCodeResend>(_onSignUpCodeResend);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (_isInvalidEmail(event.email)) {
      emit(
        state.copyWith(
          status: SignUpStatus.validationError,
          errorMessage: 'Неверный формат email',
        ),
      );
      return;
    }

    if (_isInvalidPassword(event.password)) {
      emit(
        state.copyWith(
          status: SignUpStatus.validationError,
          errorMessage: 'Пароль должен содержать минимум 8 символов',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SignUpStatus.loading,
        email: event.email,
        errorMessage: '',
      ),
    );

    try {
      // final result = await authRepository.signUp(event.email, event.password);

      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: SignUpStatus.codePending,
          successMessage: 'Код подтверждения отправлен на ${event.email}',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: _getErrorMessage(error),
        ),
      );
    }
  }

  Future<void> _onSignUpCodeSubmitted(
    SignUpCodeSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (event.code.isEmpty || event.code.length != 6) {
      emit(
        state.copyWith(
          status: SignUpStatus.validationError,
          errorMessage: 'Введите корректный 6-значный код',
        ),
      );
      return;
    }

    emit(state.copyWith(status: SignUpStatus.codeVerifying, errorMessage: ''));

    try {
      // final result = await authRepository.verifyCode(event.email, event.code);

      await Future.delayed(const Duration(seconds: 1));

      emit(
        state.copyWith(
          status: SignUpStatus.completed,
          successMessage: 'Регистрация успешно завершена!',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: _getErrorMessage(error),
        ),
      );
    }
  }

  Future<void> _onSignUpCodeResend(
    SignUpCodeResend event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SignUpStatus.codeResending, errorMessage: ''));

    try {
      // await authRepository.resendCode(event.email);

      await Future.delayed(const Duration(seconds: 1));

      emit(
        state.copyWith(
          status: SignUpStatus.codePending,
          successMessage: 'Код отправлен повторно на ${event.email}',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: _getErrorMessage(error),
        ),
      );
    }
  }

  bool _isInvalidEmail(String email) {
    return !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isInvalidPassword(String password) {
    return password.length < 8;
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('network')) {
      return 'Проблемы с сетью. Проверьте подключение.';
    } else if (error.toString().contains('email_exists')) {
      return 'Пользователь с таким email уже существует';
    } else if (error.toString().contains('invalid_code')) {
      return 'Неверный код подтверждения';
    }
    return 'Произошла ошибка. Попробуйте еще раз.';
  }
}
