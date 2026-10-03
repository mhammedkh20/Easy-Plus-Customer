part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class CategoriesFailed extends MainState {
  final String message;
  CategoriesFailed({required this.message});
}

class GetLastSeenDriversFailed extends MainState {
  final String message;
  GetLastSeenDriversFailed({required this.message});
}

class GetLastSeenDriversSuccess extends MainState {}
