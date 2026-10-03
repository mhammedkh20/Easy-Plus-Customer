part of 'complaints_cubit.dart';

@immutable
abstract class ComplaintsState {}

class ComplaintsInitial extends ComplaintsState {}

// ! opration Get Complaints
class ComplaintsLoading extends ComplaintsState {}

class ComplaintsSuccess extends ComplaintsState {
  final String message;
  ComplaintsSuccess({required this.message});
}

class ComplaintsFailed extends ComplaintsState {
  final String message;
  ComplaintsFailed({required this.message});
}

class ComplaintsLoadingPagination extends ComplaintsState {}

// ! opration Post Complaints
class ComplaintPostLoading extends ComplaintsState {}

class ComplaintPostSuccess extends ComplaintsState {
  final String message;
  final Complaints complaint;
  ComplaintPostSuccess({required this.message, required this.complaint});
}

class ComplaintPostFailed extends ComplaintsState {
  final String message;
  ComplaintPostFailed({required this.message});
}

// ! opration Get Order Ids
class OrderIdsLoading extends ComplaintsState {}

class OrderIdsSuccess extends ComplaintsState {
  final String message;
  OrderIdsSuccess({required this.message});
}

class OrderIdsFailed extends ComplaintsState {
  final String message;
  OrderIdsFailed({required this.message});
}
