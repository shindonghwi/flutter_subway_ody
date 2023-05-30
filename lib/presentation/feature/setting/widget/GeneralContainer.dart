import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/feature/setting/widget/RefreshSwitch.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class GeneralContainer extends StatelessWidget {
  const GeneralContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "일반",
            style: getTextTheme(context).bold.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 12,
                ),
          ),
          const RefreshSwitch(),
          Text(
            "버튼을 활성화 하면 10초마다 정보를 새로고침 합니다",
            style: getTextTheme(context).regular.copyWith(
                  color: const Color(0xFFB1B1B1),
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
