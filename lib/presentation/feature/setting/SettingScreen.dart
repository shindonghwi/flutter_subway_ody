import 'package:flutter/material.dart';
import 'package:subway_ody/presentation/feature/setting/widget/EtcContainer.dart';
import 'package:subway_ody/presentation/feature/setting/widget/GeneralContainer.dart';
import 'package:subway_ody/presentation/feature/setting/widget/InquireContainer.dart';
import 'package:subway_ody/presentation/feature/setting/widget/SettingAppBar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const GeneralContainer(),
            _divider(context),
            const EtcContainer(),
            _divider(context),
            const InquireContainer(),
          ],
        ),
      ),
    );
  }

  Container _divider(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xFFEDEDED),
    );
  }
}
