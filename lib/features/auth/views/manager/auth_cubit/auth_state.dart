part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//  opration Login
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String message;
  LoginSuccess({required this.message});
}

class LoginFailed extends AuthState {
  final String message;
  final bool unauthorized;

  LoginFailed({required this.message, this.unauthorized = false});
}

//  ! opration Register
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final String message;
  RegisterSuccess({required this.message});
}

class RegisterFailed extends AuthState {
  final String message;
  RegisterFailed({required this.message});
}

// ! opration Verify Code
class VerifyCodeLoading extends AuthState {}

class VerifyCodeSuccess extends AuthState {
  final String message;
  VerifyCodeSuccess({required this.message});
}

class VerifyCodeFailed extends AuthState {
  final String message;
  VerifyCodeFailed({required this.message});
}

// ! opration Forget Password
class ForgetPasswordLoading extends AuthState {}

class ForgetPasswordSuccess extends AuthState {
  final String message;
  ForgetPasswordSuccess({required this.message});
}

class ForgetPasswordFailed extends AuthState {
  final String message;
  ForgetPasswordFailed({required this.message});
}

// ! opration Reset Password
class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess({required this.message});
}

class ResetPasswordFailed extends AuthState {
  final String message;
  ResetPasswordFailed({required this.message});
}

// ! opration Reset Password
class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {
  final String message;
  LogoutSuccess({required this.message});
}

class LogoutFailed extends AuthState {
  final String message;
  LogoutFailed({required this.message});
}
