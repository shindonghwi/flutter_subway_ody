import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/presentation/feature/main/widget/AdvertiseContainer.dart';
import 'package:subway_ody/presentation/feature/main/widget/MainAppBar.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayDirectionETA.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayListDivider.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayTitle.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Column(
        children:   const [
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: getColorScheme(context).colorPrimary,
        child: SvgPicture.asset('assets/imgs/refresh.svg'),
      )
    );
  }
}
