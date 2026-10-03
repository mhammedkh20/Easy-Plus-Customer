part of 'on_boarding_cubit.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class GetDataFailed extends OnBoardingState {
  final String message;
  GetDataFailed({required this.message});
}

class GetDataSuccess extends OnBoardingState {}
