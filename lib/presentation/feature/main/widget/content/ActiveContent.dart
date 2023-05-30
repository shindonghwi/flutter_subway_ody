import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/feature/main/widget/AdvertiseContainer.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayDirectionETA.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayListDivider.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayTitle.dart';

class ActiveContent extends HookWidget {
  const ActiveContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        children: const [
          SizedBox(height: 32),
          SubwayTitle(),
          SizedBox(height: 22),
          SubwayDirectionETA(),
          SizedBox(height: 28),
          SubwayListDivider(),
          SizedBox(height: 74),
          SubwayDirectionETA(),
          SizedBox(height: 28),
          SubwayListDivider(),
          AdvertiseContainer(),
          SizedBox(height: 32),
          SubwayTitle(),
          SizedBox(height: 22),
          SubwayDirectionETA(),
          SizedBox(height: 28),
          SubwayListDivider(),
          SizedBox(height: 74),
          SubwayDirectionETA(),
          SizedBox(height: 28),
          SubwayListDivider(),
          AdvertiseContainer(),
        ],
      ),
    );
  }
}
