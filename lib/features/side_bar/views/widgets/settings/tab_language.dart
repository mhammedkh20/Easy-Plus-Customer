import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/settings/item_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabLanguage extends StatelessWidget {
  const TabLanguage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      height: 76.h,
      enableShadow: false,
      paddingHorizontal: 11,
      paddingVertical: 11,
      borderRadius: 50,
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          int index = LanguageCubit.get(context).indexLang;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                ItemLanguage(
                  onTap: () async {
                    if (index != 0) {
                      await LanguageCubit.get(context).changeLanguage(0);
                      await MainCubit.get(context).getAppConfig(context);
                    }
                  },
                  title: AppLocalizations.of(context)!.arabic,
                  isSelected: index == 0,
                ),
                ItemLanguage(
                  onTap: () async {
                    if (index != 1) {
                      await LanguageCubit.get(context).changeLanguage(1);
                      await MainCubit.get(context).getAppConfig(context);
                    }
                  },
                  title: AppLocalizations.of(context)!.english,
                  isSelected: index == 1,
                ),
                ItemLanguage(
                  onTap: () async {
                    if (index != 2) {
                      await LanguageCubit.get(context).changeLanguage(2);
                      await MainCubit.get(context).getAppConfig(context);
                    }
                  },
                  title: AppLocalizations.of(context)!.urdu,
                  isSelected: index == 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
