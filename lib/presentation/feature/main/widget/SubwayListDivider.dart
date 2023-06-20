import 'package:flutter/material.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
import 'package:subway_ody/presentation/feature/main/widget/SubwayPositionList.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/SystemUtil.dart';

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
    final firstDestination = stationInfo.destination;
    final btrainSttus = stationInfo.btrainSttus;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 72,
          child: SubwayPositionList(
            subwayList: subwayList,
            positionList: positionList,
            mainColor: mainColor,
            isUp: stationInfo.ordkey.startsWith("0"),
            btrainSttus: btrainSttus,
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
  final context = SubwayOdyApp.navigatorKey.currentContext as BuildContext;

  SubwayDividerAndNamePainter({
    required this.subwayList,
    required this.mainColor,
    required this.isUp,
  });

  String insertNewlineAfterFirstThreeCharacters(String text) {
    var lineLimit = 7;
    var firstLineLimit = 5;
    switch (SubwayOdyApp.currentLocale.languageCode) {
      case "ko":
        lineLimit = 7;
        firstLineLimit = 5;
        break;
      case "en":
        lineLimit = 6;
        firstLineLimit = 8;
        break;
      case "ja":
        lineLimit = 6;
        firstLineLimit = 5;
        break;
      case "zh":
        lineLimit = 6;
        firstLineLimit = 5;
        break;
    }

    String parseText = text;

    if (text.length <= firstLineLimit) {
      return text;
    }

    if (parseText.contains("(")) {
      final mainText = text.substring(0, text.indexOf("("));
      var detailText = text.substring(text.indexOf("(")).length > lineLimit
          ? "${text.substring(text.indexOf("(")).substring(0, lineLimit)}\n${text.substring(text.indexOf("(")).substring(lineLimit)}"
          : text.substring(text.indexOf("("));

      final secondText = detailText.split("\n").last;

      if (secondText.length >= lineLimit) {
        detailText = "${secondText.substring(0, lineLimit)}\n${secondText.substring(lineLimit)}";
      }
      parseText = "$mainText\n$detailText";
      return parseText;
    } else {
      final firstThreeCharacters = text.substring(0, firstLineLimit - 1);
      var remainingCharacters = text.substring(firstLineLimit - 1);

      final secondText = remainingCharacters.split("\n").last;
      if (secondText.length >= lineLimit) {
        remainingCharacters =
            "${secondText.substring(0, lineLimit)}\n${secondText.substring(lineLimit)}";
      }

      return '$firstThreeCharacters\n$remainingCharacters';
    }
  }

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = mainColor
      ..strokeWidth = (size.height / 2)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final barWidth = size.width - (2 * radius);
    final barHeight = size.height - (2 * radius);

    Offset startPoint;
    Offset endPoint;

    startPoint = Offset(radius, size.height / 2 - barHeight / 2);
    endPoint = Offset(size.width - radius, size.height / 2 - barHeight / 2);

    canvas.drawLine(startPoint, endPoint, paint);

    var spacing = barWidth / (subwayList.length - 1);

    if (subwayList.length == 1) {
      spacing = barWidth;
    }

    final circleInnerPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final circleBorderPaint = Paint()
      ..color = mainColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;



    for (int index = 0; index < subwayList.length; index++) {
      final breakpointX = radius + (index * spacing);
      final breakpointY = size.height / 2;

      Offset circleInnerCenter;
      Offset circleBorderCenter;
      if (subwayList.length == 1){
        if (isUp){
          circleInnerCenter = Offset(0, breakpointY);
          circleBorderCenter = Offset(0, breakpointY);
        }else{
          circleInnerCenter = Offset(size.width, breakpointY);
          circleBorderCenter = Offset(size.width, breakpointY);
        }
      }else{
        circleInnerCenter = Offset(breakpointX, breakpointY);
        circleBorderCenter = Offset(breakpointX, breakpointY);
      }

      if (isUp && index == 0){
        canvas.drawCircle(circleBorderCenter, radius + 2, circleBorderPaint);
        canvas.drawCircle(circleInnerCenter, radius, circleInnerPaint);
      }else if (!isUp && index == subwayList.length - 1){
        canvas.drawCircle(circleBorderCenter, radius + 2, circleBorderPaint);
        canvas.drawCircle(circleInnerCenter, radius, circleInnerPaint);
      }else{
        canvas.drawCircle(circleBorderCenter, radius + 2, circleBorderPaint);
      }



      final stationName = insertNewlineAfterFirstThreeCharacters(
          SubwayUtil.findLanguageSubwayName(subwayList[index],
              languageType: SystemUtil.getLanguageType(
                SubwayOdyApp.currentLocale,
              )));

      final textPainter = TextPainter(
        text: TextSpan(
          text: stationName,
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

      double textX = 0.0;
      double textY = 0.0;

      if (subwayList.length == 1){
        if (isUp){
          textX = 0 - (textPainter.width / 2);
          textY = circleInnerCenter.dy + radius + 10;
        }else{
          textX = size.width - (textPainter.width / 2);
          textY = circleInnerCenter.dy + radius + 10;
        }
      }else{
        textX = breakpointX - (textPainter.width / 2);
        textY = circleInnerCenter.dy + radius + 10;
      }

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
