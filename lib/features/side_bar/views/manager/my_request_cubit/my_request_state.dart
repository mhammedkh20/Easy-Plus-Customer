part of 'my_request_cubit.dart';

@immutable
abstract class MyRequestState {}

class MyRequestInitial extends MyRequestState {}

//! Get My Order

class MyOrderLoading extends MyRequestState {}

class MyOrderLoadingPagination extends MyRequestState {}

class MyOrderSuccess extends MyRequestState {
  final String message;
  MyOrderSuccess({required this.message});
}

class MyOrderFailed extends MyRequestState {
  final String message;
  MyOrderFailed({required this.message});
}

//! Get OrderDetails

class OrderDetailsLoading extends MyRequestState {}

class OrderDetailsSuccess extends MyRequestState {
  final String message;
  OrderDetailsSuccess({required this.message});
}

class OrderDetailsFailed extends MyRequestState {
  final String message;
  OrderDetailsFailed({required this.message});
}

//! Change status Offer
class ChangeOfferStatusLoading extends MyRequestState {}

class ChangeOfferStatusSuccess extends MyRequestState {
  final String message;
  final bool orderAccepted;
  ChangeOfferStatusSuccess({
    required this.message,
    this.orderAccepted = false,
  });
}

class ChangeOfferStatusFailed extends MyRequestState {
  final String message;
  ChangeOfferStatusFailed({required this.message});
}

//! finish Order
class FinishOrderLoading extends MyRequestState {}

class FinishOrderSuccess extends MyRequestState {
  final String message;
  final bool isRateOrder;
  FinishOrderSuccess({
    required this.message,
    required this.isRateOrder,
  });
}

class FinishOrderFailed extends MyRequestState {
  final String message;
  FinishOrderFailed({required this.message});
}
