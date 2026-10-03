import 'package:bloc/bloc.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  static LanguageCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  // ! 0 is mean arabic
  // ! 1 is mean english
  // ! 2 is mean ordo
  int indexLang = 0;
  changeLanguage(int index) async {
    indexLang = index;
    await SharedPrefController().setLang(
      indexLang == 0
          ? 'ar'
          : indexLang == 1
              ? 'en'
              : 'ur',
    );
    emit(LanguageInitial());
  }

  changeIndexLang(int index) async {
    indexLang = index;
    emit(LanguageInitial());
  }
}
