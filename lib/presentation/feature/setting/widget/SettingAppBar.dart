import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SettingAppBar extends HookWidget with PreferredSizeWidget {
  const SettingAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFDFDFD),
      bottomOpacity: 0.0,
      elevation: 1.0,
      shadowColor: const Color(0xFFEDEDED),
      automaticallyImplyLeading: false,
      title: Text(
        getAppLocalizations(context).settingTitle,
        style: getTextTheme(context).medium.copyWith(
              color: const Color(0xFF2F2F2F),
              fontSize: 18,
              height: 1.28,
            ),
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              'assets/imgs/icon_back.svg',
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
