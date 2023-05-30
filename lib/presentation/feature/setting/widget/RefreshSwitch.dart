import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/feature/setting/widget/SwitchCheckBox.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class RefreshSwitch extends HookWidget {
  const RefreshSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSwitchOn = useState<bool>(false);

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
              onChanged: (value) {
                isSwitchOn.value = !value;
              },
            ),
          )
        ],
      ),
    );
  }
}
