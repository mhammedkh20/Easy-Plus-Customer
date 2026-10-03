import 'package:easy_plus_customer/features/side_bar/model/show_order_ids_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_plus_customer/features/side_bar/data/side_bar_repo_imp.dart';
import 'package:easy_plus_customer/features/side_bar/model/complaints.dart';
import 'package:easy_plus_customer/features/side_bar/model/complaints_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final SideBarRepoImp _apiSideBar = SideBarRepoImp();
  final ImagePicker _picker = ImagePicker();

  ComplaintsCubit() : super(ComplaintsInitial());

  static ComplaintsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<Complaints> listComplaints = [];

  int total = 0;
  int page = 1;

  clearData({required bool withEmit}) {
    total = 0;
    page = 1;
    listComplaints.clear();
    if (withEmit) {
      emit(ComplaintsInitial());
    }
  }

  Future getComplaints(
    BuildContext context, {
    bool loadPagination = false,
  }) async {
    if (loadPagination) {
      emit(ComplaintsLoadingPagination());
      page++;
    } else {
      clearData(withEmit: false);
      emit(ComplaintsLoading());
    }

    ComplaintsResponse? responseData =
        await _apiSideBar.getComplaintsResponse(page: page);

    if (responseData != null && responseData.status!) {
      total = responseData.meta!.total ?? 0;
      listComplaints.addAll(responseData.complaints ?? []);

      emit(ComplaintsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        ComplaintsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ComplaintsFailed(message: responseData.message!));
    }
  }

  addCompaint(Complaints data) {
    listComplaints.insert(0, data);
    emit(ComplaintsInitial());
  }

  Future sendComplaint(
    BuildContext context, {
    required String orderId,
    required String desc,
  }) async {
    emit(ComplaintPostLoading());

    ComplaintsResponse? responseData = await _apiSideBar.sendComplaints(
      orderId: orderId,
      desc: desc,
    );

    if (responseData != null && responseData.status!) {
      emit(ComplaintPostSuccess(
          message: responseData.message!, complaint: responseData.object!));
    }

    if (responseData == null) {
      emit(
        ComplaintPostFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ComplaintPostFailed(message: responseData.message!));
    }
  }

  List<int> orderIds = [];

  Future getShowOrderIds(BuildContext context) async {
    emit(OrderIdsLoading());

    ShowOrderIdsResponse? responseData = await _apiSideBar.showOrderIds();

    if (responseData != null && responseData.status!) {
      orderIds.addAll(responseData.data ?? []);
      emit(OrderIdsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        OrderIdsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(OrderIdsFailed(message: responseData.message!));
    }
  }

  List<String> imagesLostItems = [];
  Future pickImageItems() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagesLostItems.add(image.path);
      emit(ComplaintsInitial());
    }
  }

  deleteImageItem(int index) async {
    imagesLostItems.removeAt(index);
    emit(ComplaintsInitial());
  }
}
