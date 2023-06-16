import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/usecases/local/GetAppModeUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PatchAppModeUseCase.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/RestartWidget.dart';

class PopUpHiddenMenu extends HookWidget {
  const PopUpHiddenMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hiddenState = useState<bool>(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        hiddenState.value = await GetIt.instance<GetAppModeUseCase>().call();
      });
    }, []);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Image.asset(
          'assets/imgs/marker.png',
          width: 20,
          height: 24,
        ),
        const SizedBox(height: 32),
        Text(
          hiddenState.value
              ? getAppLocalizations(context).popup_hidden_menu_off_title
              : getAppLocalizations(context).popup_hidden_menu_on_title,
          style: getTextTheme(context).medium.copyWith(
                color: const Color(0xFF2F2F2F),
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: getColorScheme(context).colorPrimary,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(5)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                await GetIt.instance<PatchAppModeUseCase>().call(!hiddenState.value);
                Navigator.of(context).pop();
                RestartWidget.restartApp(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getAppLocalizations(context).commonConfirm,
                  style: getTextTheme(context).medium.copyWith(
                        color: getColorScheme(context).white,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
