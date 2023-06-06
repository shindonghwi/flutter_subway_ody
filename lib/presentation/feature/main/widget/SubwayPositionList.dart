import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';

class SubwayPositionList extends HookWidget {
  const SubwayPositionList({
    super.key,
    required this.subwayList,
    required this.positionList,
    required this.mainColor,
    required this.isUp,
    required this.destination,
  });

  final List<String> subwayList;
  final List<Pair<int, SubwayPositionModel?>> positionList;
  final Color mainColor;
  final String destination;
  final bool isUp;

  @override
  Widget build(BuildContext context) {
    Color getRandomColor() {
      Random random = Random();
      int r = random.nextInt(256); // 0부터 255까지의 랜덤한 값을 생성
      int g = random.nextInt(256);
      int b = random.nextInt(256);
      return Color.fromRGBO(r, g, b, 1.0).withOpacity(random.nextDouble());
    }

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: getMediaQuery(context).size.width * 0.064,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: List.generate(positionList.length, (index) {
            return Positioned.fill(
              left: index * getMediaQuery(context).size.width * 0.088,
              child: Align(
                alignment: Alignment.centerLeft,
                child: positionList[index].first != -1 ? Container(
                  width: getMediaQuery(context).size.width * 0.174, // 첫 번째 아이템의 넓이
                  color: getRandomColor(),
                  child: SubwayPositionItem(
                    mainColor: mainColor,
                    isUp: isUp,
                    destination: destination,
                  ),
                ) : const SizedBox(),
              ),
            );
          }).toList()
        ));
    // Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 25),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: List.generate(subwayList.length * 2 - 1, (index) {
    //       return index % 2 == 0
    //           ? SubwayPositionItem(
    //               mainColor: mainColor,
    //               isUp: isUp,
    //           destination: "test",
    //       )
    //           : const SizedBox();
    //     }),
    //   ),
    // ),
    // Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 40),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: List.generate(subwayList.length * 2 - 1, (index) {
    //       return index % 2 == 1
    //           ? SubwayPositionItem(
    //               mainColor: mainColor,
    //               isUp: isUp,
    //         destination: "test",
    //             )
    //           : const SizedBox();
    //     }),
    //   ),
    // ),
    // ],
    // );
  }
}

class SubwayPositionItem extends StatelessWidget {
  final Color mainColor;
  final bool isUp;
  final String destination;

  const SubwayPositionItem({
    Key? key,
    required this.mainColor,
    required this.isUp,
    required this.destination,
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
          child: Text(destination,
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
