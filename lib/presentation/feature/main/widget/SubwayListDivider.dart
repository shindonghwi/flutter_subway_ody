import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayPositionList.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SubwayListDivider extends StatelessWidget {
  final SubwayDirectionStationModel stationInfo;
  final Color mainColor;

  const SubwayListDivider({
    super.key,
    required this.stationInfo,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final subwayList = stationInfo.nameList;
    final positionList = stationInfo.subwayPositionList;
    final destination = "${stationInfo.destination}(${stationInfo.btrainSttus})";

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: SubwayPositionList(
            subwayList: subwayList,
            positionList: positionList,
            mainColor: mainColor,
            isUp: stationInfo.ordkey.startsWith("0"),
            destination: destination,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: getMediaQuery(context).size.width * 0.141,
          ),
          width: double.infinity,
          height: 8,
          child: CustomPaint(
            painter: SubwayDividerAndNamePainter(
              subwayList: subwayList,
              mainColor: mainColor,
              isUp: stationInfo.ordkey.startsWith("0"),
            ),
          ),
        ),
      ],
    );
  }
}

class SubwayDividerAndNamePainter extends CustomPainter {
  final List<String> subwayList;
  final Color mainColor;
  final bool isUp;
  final double radius = 4;
  final context = SubwayOdyGlobalVariable.naviagatorState.currentContext as BuildContext;

  SubwayDividerAndNamePainter({
    required this.subwayList,
    required this.mainColor,
    required this.isUp,
  });

  String insertNewlineAfterFirstThreeCharacters(String text) {
    if (text.length <= 4) {
      return text;
    }

    final firstThreeCharacters = text.substring(0, 3);
    final remainingCharacters = text.substring(3);

    return '$firstThreeCharacters\n$remainingCharacters';
  }

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = mainColor
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final barWidth = size.width - (2 * radius);
    final barHeight = size.height - (2 * radius);

    final startPoint = Offset(radius, size.height / 2 - barHeight / 2);
    final endPoint = Offset(size.width - radius, size.height / 2 - barHeight / 2);

    canvas.drawLine(startPoint, endPoint, paint);

    final spacing = barWidth / (subwayList.length - 1);

    final circleInnerPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final circleBorderPaint = Paint()
      ..color = mainColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    for (int index = 0; index < subwayList.length; index++) {
      final breakpointX = radius + (index * spacing);
      final breakpointY = size.height / 2;

      final circleInnerCenter = Offset(breakpointX, breakpointY);
      final circleBorderCenter = Offset(breakpointX, breakpointY);
      canvas.drawCircle(circleBorderCenter, radius + 2, circleBorderPaint);
      canvas.drawCircle(circleInnerCenter, radius, circleInnerPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: insertNewlineAfterFirstThreeCharacters(subwayList[index]),
          style: !isUp && index == subwayList.length - 1 || isUp && index == 0
              ? getTextTheme(context).bold.copyWith(
                    color: const Color(0xFF2F2F2F),
                    fontSize: 14,
                    height: 1.42,
                  )
              : getTextTheme(context).medium.copyWith(
                    color: const Color(0xFFD6D6D6),
                    fontSize: 14,
                    height: 1.42,
                  ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final textX = breakpointX - (textPainter.width / 2);
      final textY = circleInnerCenter.dy + radius + 10;
      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
