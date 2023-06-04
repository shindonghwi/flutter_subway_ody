import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SubwayPositionList extends HookWidget {
  const SubwayPositionList({
    super.key,
    required this.subwayList,
    required this.positionList,
    required this.mainColor,
    required this.isUp,
  });

  final List<String> subwayList;
  final List<int> positionList;
  final Color mainColor;
  final bool isUp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(subwayList.length * 2 - 1, (index) {
              positionList.removeWhere((element) => element == -1);
              return positionList.contains(index) && index % 2 == 0
                  ? Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SubwayPositionItem(
                        mainColor: mainColor,
                        isUp: isUp,
                      ),
                    )
                  : const Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    );
            }),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(subwayList.length * 2 - 1, (index) {
              positionList.removeWhere((element) => element == -1);
              return positionList.contains(index) && index % 2 == 1
                  ? Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SubwayPositionItem(
                        mainColor: mainColor,
                        isUp: isUp,
                      ),
                    )
                  : const Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    );
            }),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 25),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: List.generate(subwayList.length * 2 - 1, (index) {
        //       return index % 2 == 0
        //           ? SubwayPositionItem(
        //               mainColor: mainColor,
        //               isUp: isUp,
        //             )
        //           : const SizedBox();
        //     }),
        //   ),
        // ),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 60),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: List.generate(subwayList.length * 2 - 1, (index) {
        //       return index % 2 == 1
        //           ? SubwayPositionItem(
        //               mainColor: mainColor,
        //               isUp: isUp,
        //             )
        //           : const SizedBox();
        //     }),
        //   ),
        // ),
      ],
    );
  }
}

class SubwayPositionItem extends StatelessWidget {
  final Color mainColor;
  final bool isUp;

  const SubwayPositionItem({
    Key? key,
    required this.mainColor,
    required this.isUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text("동인천급행",
              style: getTextTheme(context).bold.copyWith(
                    color: const Color(0xFF2F2F2F),
                    fontSize: 12,
                  )),
        ),
        Transform(
          transform: Matrix4.identity()..scale(isUp ? 1.0 : -1.0, 1.0, 1.0),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/imgs/subway.svg',
            colorFilter: ColorFilter.mode(
              mainColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
