import 'package:easy_plus_customer/features/request_services/model/places/response_place_details.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_predictions.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/features/request_services/data/order_repo_imp.dart';
import 'package:easy_plus_customer/features/request_services/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main/model/response_category.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final OrderRepoImp _orderRepoImp = OrderRepoImp();

  ServiceCubit() : super(ServiceInitial());

  static ServiceCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<String> slider = [];
  Future getSlider(BuildContext context, {required int categoryId}) async {
    slider.clear();
    emit(SliderLoading());

    ResponseCategory? responseCat =
        await _orderRepoImp.getSliderCategory(categoryId);

    if (responseCat != null && responseCat.status!) {
      slider = responseCat.slider ?? [];
      emit(SliderSuccess(message: responseCat.message!));
    }

    if (responseCat == null) {
      emit(
        SliderFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseCat.status!) {
      emit(SliderFailed(message: responseCat.message!));
    }
  }

  int indexTypeNavigationRange = 0;
  changeTypeNavigationRange(int index) {
    indexTypeNavigationRange = index;
    emit(ServiceInitial());
  }

  int indexRequestCategory = 0;
  changeRequestCategory(int index) {
    indexRequestCategory = index;
    emit(ServiceInitial());
  }

  bool isExpandedRequestCategory = true;
  changeIsExpandedRequestCategory(bool status) {
    isExpandedRequestCategory = status;
    emit(ServiceInitial());
  }

  int indexReviewType = 0;
  changeReviewType(int index) {
    indexReviewType = index;
    emit(ServiceInitial());
  }

  bool isExpandedReviewType = true;
  changeIsExpandedReviewType(bool status) {
    isExpandedReviewType = status;
    emit(ServiceInitial());
  }

  int indexShoppingType = 0;
  changeShoppingType(int index) {
    indexShoppingType = index;
    emit(ServiceInitial());
  }

  bool isExpandedShoppingType = true;
  changeIsExpandedShoppingType(bool status) {
    isExpandedShoppingType = status;
    emit(ServiceInitial());
  }

  int indexTourType = 0;
  changeTourType(int index) {
    indexTourType = index;
    emit(ServiceInitial());
  }

  bool isExpandedTourType = true;
  changeIsExpandedTourType(bool status) {
    isExpandedTourType = status;
    emit(ServiceInitial());
  }

  int indexRoundCategory = 0;
  changeRoundCategory(int index) {
    indexRoundCategory = index;
    emit(ServiceInitial());
  }

  int indexReservationPeriod = 0;
  changeReservationPeriod(int index) {
    indexReservationPeriod = index;
    emit(ServiceInitial());
  }

  int numberOfHours = 1;
  changeHumberOfHours(int index) {
    numberOfHours = index;
    emit(ServiceInitial());
  }

  increaseHours() {
    numberOfHours++;
    emit(ServiceInitial());
  }

  decreaseHours() {
    if (numberOfHours > 1) {
      numberOfHours--;
      emit(ServiceInitial());
    }
  }

  clearHours() {
    numberOfHours = 1;
    emit(ServiceInitial());
  }

  int indexVehicleClass = 0;
  changeVehicleClass(int index) {
    indexVehicleClass = index;
    emit(ServiceInitial());
  }

  bool isExpandedVehicleClass = true;
  changeIsExpandedVehicleClass(bool status) {
    isExpandedVehicleClass = status;
    emit(ServiceInitial());
  }

  int indexDriversGender = 0;
  changeDriversGender(int index) {
    indexDriversGender = index;
    emit(ServiceInitial());
  }

  int indexNavigationRange = 0;
  changeNavigationRange(int index) {
    indexNavigationRange = index;
    if (indexNavigationRange == 1 || indexNavigationRange == 2) {
      indexTypeOfRide = 0;
    }
    emit(ServiceInitial());
  }

  int indexTypeOfRide = 0;
  changeTypeOfRide(int index) {
    indexTypeOfRide = index;
    clearHours();
    emit(ServiceInitial());
  }

  int indexReservationType = 0;
  changeReservationType(int index) {
    indexReservationType = index;
    emit(ServiceInitial());
  }

  int indexSecheduledRequest = 0;
  changeSecheduledRequest(int index) {
    indexSecheduledRequest = index;
    emit(ServiceInitial());
  }

  Future sendOrder(BuildContext context, {required OrderModel order}) async {
    emit(SendOrderLoading());

    OrderResponse? responseSendOrder =
        await _orderRepoImp.postOrder(order: order);

    if (responseSendOrder != null && responseSendOrder.status!) {
      emit(
        SendOrderSuccess(
            message: responseSendOrder.message!,
            orderId: int.parse(responseSendOrder.data!.id!.toString())),
      );
    }

    if (responseSendOrder == null) {
      emit(
        SendOrderFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseSendOrder.status!) {
      emit(SendOrderFailed(message: responseSendOrder.message!));
    }
  }

  List<Predictions>? predictions;
  Future getPredictions(BuildContext context, {required String input}) async {
    emit(PredictionsLoading());

    ResponsePredictions? responsePre =
        await _orderRepoImp.getPredictions(input);

    if (responsePre != null) {
      if (responsePre.status == 'OK') {
        predictions = responsePre.predictions;
        emit(
          PredictionsSuccess(
            message: responsePre.message!,
            predictions: responsePre.predictions,
          ),
        );
      } else {
        emit(PredictionsSuccess(message: responsePre.message!));
      }
    } else {
      emit(
        PredictionsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    }
  }

  ResponsePlaceDetails? placeDetails;

  Future getPlaceDetails(BuildContext context,
      {required String placeId}) async {
    emit(PlaceDetailsLoading());

    ResponsePlaceDetails? placeDetails =
        await _orderRepoImp.getPlaceDetails(placeId);

    if (placeDetails != null) {
      if (placeDetails.status == 'OK') {
        this.placeDetails = placeDetails;
        emit(PlaceDetailsSuccess(message: placeDetails.message!));
      } else {
        emit(PlaceDetailsSuccess(message: placeDetails.message!));
      }
    } else {
      emit(
        PlaceDetailsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    }
  }

  clearPredictions() {
    predictions = null;
    emit(ServiceInitial());
  }
}
