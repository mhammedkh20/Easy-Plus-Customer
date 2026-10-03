import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'evaluation_state.dart';

class EvaluationCubit extends Cubit<EvaluationState> {
  EvaluationCubit() : super(EvaluationInitial());

  static EvaluationCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  bool arriveOnTime = true;
  changeArriveOnTime(bool status) {
    arriveOnTime = status;
    emit(EvaluationInitial());
  }

  bool vehicleCleanliness = true;
  changeVehicleCleanliness(bool status) {
    vehicleCleanliness = status;
    emit(EvaluationInitial());
  }

  bool satisfactionWithService = true;
  changeSatisfactionWithService(bool status) {
    satisfactionWithService = status;
    emit(EvaluationInitial());
  }
}
