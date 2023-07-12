import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/PostSaveUserDistanceUseCase.dart';
import 'package:subway_ody/presentation/feature/main/widget/bottom_sheet/BottomSheetUtil.dart';
import 'package:subway_ody/presentation/feature/provider/MainUiState.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class ErrorNotAvailableContent extends HookConsumerWidget {
  const ErrorNotAvailableContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/empty_subway.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 8),
              Text(
                getAppLocalizations(context).message_not_available,
                style: getTextTheme(context).regular.copyWith(
                      fontSize: 16,
                      color: const Color(0xFFB1B1B1),
                      height: 1.42,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: getColorScheme(context).colorPrimary,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      BottomSheetUtil.showDistanceBottomSheet(
                        context,
                        onComplete: (value) {
                          GetIt.instance<PostSaveUserDistanceUseCase>().call(value);
                          ref.read(mainUiStateProvider.notifier).getSubwayData(context, value);
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      child: Text(
                        getAppLocalizations(context).setDistanceTitle,
                        style: getTextTheme(context).regular.copyWith(
                              fontSize: 16,
                              color: getColorScheme(context).white,
                              height: 1.42,
                            ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
