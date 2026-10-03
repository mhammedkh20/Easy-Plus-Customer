part of 'side_bar_cubit.dart';

@immutable
abstract class SideBarState {}

class SideBarInitial extends SideBarState {}

// ! opration Contact Us
class ContactUsLoading extends SideBarState {}

class ContactUsSuccess extends SideBarState {
  final String message;
  ContactUsSuccess({required this.message});
}

class ContactUsFailed extends SideBarState {
  final String message;
  ContactUsFailed({required this.message});
}

// ! opration Report-Missing
class ReportMissingLoading extends SideBarState {}

class ReportMissingSuccess extends SideBarState {
  final String message;
  ReportMissingSuccess({required this.message});
}

class ReportMissingFailed extends SideBarState {
  final String message;
  ReportMissingFailed({required this.message});
}

// ! opration Wallet
class WalletLoading extends SideBarState {}

class WalletSuccess extends SideBarState {
  final String message;
  final int? index;
  final int? id;

  WalletSuccess({required this.message, this.index, this.id});
}

class WalletFailed extends SideBarState {
  final String message;
  WalletFailed({required this.message});
}

class BalanceLoading extends SideBarState {}

class BalanceSuccess extends SideBarState {
  final String message;
  final bool navigationPage;
  final int? id;

  BalanceSuccess({required this.message, this.id, this.navigationPage = false});
}

class BalanceFailed extends SideBarState {
  final String message;
  BalanceFailed({required this.message});
}

// ! State Privacy Policy
class PrivacyPolicyLoading extends SideBarState {}

class PrivacyPolicySuccess extends SideBarState {
  final String message;
  PrivacyPolicySuccess({required this.message});
}

class PrivacyPolicyFailed extends SideBarState {
  final String message;
  PrivacyPolicyFailed({required this.message});
}

// ! Common Qustion
class LoadingQustionData extends SideBarState {}

class QustionLoadingPagination extends SideBarState {}

class FailedQustionData extends SideBarState {
  final String message;
  FailedQustionData({required this.message});
}

class SuccessQustionData extends SideBarState {}

// ! Notification
class NotificationsLoading extends SideBarState {}

class NotificationsFailed extends SideBarState {
  final String message;
  NotificationsFailed({required this.message});
}

class NotificationsSuccess extends SideBarState {}
