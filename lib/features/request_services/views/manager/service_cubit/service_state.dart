part of 'service_cubit.dart';

@immutable
abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

//  ! send Order
class SendOrderLoading extends ServiceState {}

class SendOrderSuccess extends ServiceState {
  final String message;
  final int orderId;
  SendOrderSuccess({
    required this.message,
    required this.orderId,
  });
}

class SendOrderFailed extends ServiceState {
  final String message;
  SendOrderFailed({required this.message});
}

//  ! get Slider BY Category
class SliderLoading extends ServiceState {}

class SliderSuccess extends ServiceState {
  final String message;
  SliderSuccess({required this.message});
}

class SliderFailed extends ServiceState {
  final String message;
  SliderFailed({required this.message});
}

//  ! get Predictions
class PredictionsLoading extends ServiceState {}

class PredictionsSuccess extends ServiceState {
  final String message;
  final List<Predictions>? predictions;

  PredictionsSuccess({
    required this.message,
    this.predictions,
  });
}

class PredictionsFailed extends ServiceState {
  final String message;
  PredictionsFailed({required this.message});
}

//  ! get Details PLACE
class PlaceDetailsLoading extends ServiceState {}

class PlaceDetailsSuccess extends ServiceState {
  final String message;

  PlaceDetailsSuccess({
    required this.message,
  });
}

class PlaceDetailsFailed extends ServiceState {
  final String message;
  PlaceDetailsFailed({required this.message});
}
