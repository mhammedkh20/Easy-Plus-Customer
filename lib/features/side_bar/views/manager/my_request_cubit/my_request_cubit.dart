import 'dart:developer';

import 'package:easy_plus_customer/features/request_services/views/manager/evaluation_cubit/evaluation_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_plus_customer/features/side_bar/data/side_bar_repo_imp.dart';
import 'package:easy_plus_customer/features/side_bar/model/my_orders_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'my_request_state.dart';

class MyRequestCubit extends Cubit<MyRequestState> {
  final SideBarRepoImp _sideBarRepoImp = SideBarRepoImp();

  MyRequestCubit() : super(MyRequestInitial());

  static MyRequestCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int indexStatusMyRequest = 0;
  changeStatusMyRequest(int index) {
    indexStatusMyRequest = index;
    emit(MyRequestInitial());
  }

  int indexOrderDetails = 0;
  changeOrderDetails(int index) {
    indexOrderDetails = index;
    emit(MyRequestInitial());
  }

  List<Data> listOrder = [];
  int total = 0;
  int page = 1;

  clearData({required bool withEmit}) {
    total = 0;
    page = 1;
    listOrder.clear();
    if (withEmit) {
      emit(MyRequestInitial());
    }
  }

  Future getOrders(BuildContext context, {bool loadPagination = false}) async {
    if (loadPagination) {
      emit(MyOrderLoadingPagination());
      page++;
    } else {
      clearData(withEmit: false);
      emit(MyOrderLoading());
    }

    String status = '';
    if (indexStatusMyRequest == 0) {
      status = 'pending';
    }
    if (indexStatusMyRequest == 1) {
      status = 'accepted';
    }
    if (indexStatusMyRequest == 2) {
      status = 'done';
    }

    MyOrdersResponse? responseData = await _sideBarRepoImp.getMyOrders(
      orderId: status,
      page: page,
    );

    if (responseData != null && responseData.status!) {
      total = responseData.meta!.total ?? 0;
      listOrder.addAll(responseData.data ?? []);

      emit(MyOrderSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        MyOrderFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(MyOrderFailed(message: responseData.message!));
    }
  }

  OrderResponse? dataOrderDetails;

  Future getOrderDetails(BuildContext context, String id) async {
    emit(OrderDetailsLoading());

    OrderResponse? responseData =
        await _sideBarRepoImp.getDetailsOrder(orderId: id);

    if (responseData != null && responseData.status!) {
      dataOrderDetails = responseData;
      emit(OrderDetailsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        OrderDetailsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(OrderDetailsFailed(message: responseData.message!));
    }
  }

  Future changeStatusOffer(
    BuildContext context, {
    required int offerId,
    required int operation,
  }) async {
    // ! operation
    // ? 0 accepted
    // ? 1 refuse
    // ? 2 canceld Order
    emit(ChangeOfferStatusLoading());

    OrderResponse? responseData;
    if (operation == 0) {
      responseData =
          await _sideBarRepoImp.acceptOffer(offerId: offerId.toString());
    }
    if (operation == 1) {
      responseData =
          await _sideBarRepoImp.refuseOffer(offerId: offerId.toString());
    }

    if (operation == 2) {
      responseData =
          await _sideBarRepoImp.cancelOrder(offerId: offerId.toString());
    }

    if (responseData != null && responseData.status!) {
      if (operation == 0) {}

      if (operation == 1) {
        for (int i = 0; i < dataOrderDetails!.data!.offers!.length; i++) {
          if (dataOrderDetails!.data!.offers![i].id == offerId) {
            dataOrderDetails!.data!.offers!
                .removeWhere((element) => element.id == offerId);
          }
        }
      }

      if (operation == 2) {
        for (int i = 0; i < listOrder.length; i++) {
          if (listOrder[i].id == offerId) {
            listOrder.removeWhere((element) => element.id == offerId);
          }
        }
      }
      if (operation == 0) {
        emit(
          ChangeOfferStatusSuccess(
              message: responseData.message!, orderAccepted: true),
        );
      } else {
        emit(ChangeOfferStatusSuccess(message: responseData.message!));
      }
    }

    if (responseData == null) {
      emit(
        ChangeOfferStatusFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ChangeOfferStatusFailed(message: responseData.message!));
    }
  }

  Future finishOrder(
    BuildContext context, {
    required int orderId,
  }) async {
    emit(FinishOrderLoading());

    OrderResponse? responseData = await _sideBarRepoImp.finishOrder(
      orderId: orderId.toString(),
      isArrived: '1',
    );

    if (responseData != null && responseData.status!) {
      for (int i = 0; i < listOrder.length; i++) {
        if (listOrder[i].id == orderId) {
          listOrder.removeWhere((element) => element.id == orderId);
        }
      }

      emit(FinishOrderSuccess(
          message: responseData.message!, isRateOrder: false));
    }

    if (responseData == null) {
      emit(
        FinishOrderFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(FinishOrderFailed(message: responseData.message!));
    }
  }

  Future rateOrder(
    BuildContext context, {
    required int orderId,
    bool isRateOrder = false,
  }) async {
    emit(FinishOrderLoading());
    int rate = 0;
    if (EvaluationCubit.get(context).arriveOnTime) {
      rate += 2;
    }
    if (EvaluationCubit.get(context).vehicleCleanliness) {
      rate += 2;
    }
    if (EvaluationCubit.get(context).satisfactionWithService) {
      rate += 1;
    }
    log('rate $rate');
    OrderResponse? responseData = await _sideBarRepoImp.rateOrder(
      orderId: orderId.toString(),
      rate: '$rate',
    );

    if (responseData != null && responseData.status!) {
      emit(FinishOrderSuccess(
          message: responseData.message!, isRateOrder: isRateOrder));
    }

    if (responseData == null) {
      emit(
        FinishOrderFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(FinishOrderFailed(message: responseData.message!));
    }
  }
}
