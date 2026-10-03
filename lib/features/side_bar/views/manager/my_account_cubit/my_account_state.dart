part of 'my_account_cubit.dart';

@immutable
abstract class MyAccountState {}

class MyAccountInitial extends MyAccountState {}

// ! opration Update User
class UpdateUserLoading extends MyAccountState {}

class UpdateUserSuccess extends MyAccountState {
  final String message;
  UpdateUserSuccess({required this.message});
}

class UpdateUserFailed extends MyAccountState {
  final String message;
  UpdateUserFailed({required this.message});
}

// ! opration Change Password
class ChangePasswordLoading extends MyAccountState {}

class ChangePasswordSuccess extends MyAccountState {
  final String message;
  ChangePasswordSuccess({required this.message});
}

class ChangePasswordFailed extends MyAccountState {
  final String message;
  ChangePasswordFailed({required this.message});
}
