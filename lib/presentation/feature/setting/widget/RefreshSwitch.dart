import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/domain/usecases/local/GetAutoRefreshCallUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PostAutoRefreshCallUseCase.dart';
import 'package:subway_ody/presentation/feature/provider/AutoRefreshNotifier.dart';
import 'package:subway_ody/presentation/feature/setting/widget/SwitchCheckBox.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class RefreshSwitch extends HookConsumerWidget {
  const RefreshSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final autoRefresh = ref.watch<bool>(autoRefreshProvider);
    final isSwitchOn = useState(autoRefresh);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "새로고침",
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            width: 53,
            height: 32,
            child: SwitchCheckBox(
              isOn: isSwitchOn.value,
              onChanged: (value) async {
                final isComplete =
                    await GetIt.instance<PostAutoRefreshCallUseCase>().call(!value);
                if (isComplete) {
                  isSwitchOn.value = !value;
                } else {
                  /// TODO 새로고침 저장 에러
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
