import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/features/auth/data/auth_repo_imp.dart';
import 'package:easy_plus_customer/features/auth/model/response_sign_up.dart';
import 'package:easy_plus_customer/features/auth/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final AuthRepoImp _authRepoImp = AuthRepoImp();

  MyAccountCubit() : super(MyAccountInitial());

  static MyAccountCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  String? pathImage;
  bool picked = false;
  Future pickImageUser() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pathImage = image.path;
      picked = true;

      emit(MyAccountInitial());
    }
  }

  User? userData;

  getUserDataFromShared() async {
    userData = SharedPrefController().getDataUser();
    if (userData!.id == -1) {
      userData = null;
      return;
    }
  }

  int indexSelected = -1;
  changeGenderUser(int index) {
    indexSelected = index;
    emit(MyAccountInitial());
  }

  Future updateUser(BuildContext context, {required User user}) async {
    emit(UpdateUserLoading());

    ResponseAuth? responseUpdateUser =
        await _authRepoImp.updateAccount(user: user);

    if (responseUpdateUser != null && responseUpdateUser.status!) {
      emit(UpdateUserSuccess(message: responseUpdateUser.message!));
      userData = responseUpdateUser.user!;
      picked = false;
      await SharedPrefController().saveDataUser(responseUpdateUser.user!);
    }

    if (responseUpdateUser == null) {
      emit(
        UpdateUserFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseUpdateUser.status!) {
      emit(UpdateUserFailed(message: responseUpdateUser.message!));
    }
  }

  Future changePassword(
    BuildContext context, {
    required String currentPass,
    required String newPass,
    required String confirmPass,
  }) async {
    emit(ChangePasswordLoading());

    ResponseAuth? responseData = await _authRepoImp.changePassword(
      confirmPass: confirmPass,
      currentPass: currentPass,
      newPass: newPass,
    );

    if (responseData != null && responseData.status!) {
      emit(ChangePasswordSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        ChangePasswordFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      emit(ChangePasswordFailed(message: responseData.message!));
    }
  }
}
