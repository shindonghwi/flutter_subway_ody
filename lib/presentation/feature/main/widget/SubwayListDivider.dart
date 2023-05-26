import 'package:flutter/material.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SubwayListDivider extends StatelessWidget {
  const SubwayListDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final subwayList = [
      "마곡나루",
      "개봉",
      "동대문역사문화공원",
      "장한평",
      "영등포구청",
    ];

    final subwayList2 = [
      "마곡나루",
      "개봉",
      "동대문역사문화공원",
      "영등포구청",
    ];

    final subwayList3 = [
      "마곡나루",
      "개봉",
      "영등포구청",
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 47),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(subwayList.length * 2 - 1, (index) {
              return Text("$index", style: getTextTheme(context).medium,);
            }).toList(),
          ),
          SizedBox(
            width: double.infinity,
            height: 8,
            child: CustomPaint(
              painter: SubwayDividerAndNamePainter(
                subwayList: subwayList,
                mainColor: getColorScheme(context).colorLine8,
                isSubwayDirectionLeft: true,
              ),
            ),
          ),
          SizedBox(height: 72,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(subwayList2.length * 2 - 1, (index) {
              return Text("$index", style: getTextTheme(context).medium,);
            }).toList(),
          ),
          SizedBox(
            width: double.infinity,
            height: 8,
            child: CustomPaint(
              painter: SubwayDividerAndNamePainter(
                subwayList: subwayList2,
                mainColor: getColorScheme(context).colorLine4,
                isSubwayDirectionLeft: true,
              ),
            ),
          ),
          SizedBox(height: 72,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(subwayList3.length * 2 - 1, (index) {
              return Text("$index", style: getTextTheme(context).medium,);
            }).toList(),
          ),
          SizedBox(
            width: double.infinity,
            height: 8,
            child: CustomPaint(
              painter: SubwayDividerAndNamePainter(
                subwayList: subwayList3,
                mainColor: getColorScheme(context).colorLine4,
                isSubwayDirectionLeft: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubwayDividerAndNamePainter extends CustomPainter {
  final List<String> subwayList;
  final Color mainColor;
  final bool isSubwayDirectionLeft;
  final double radius = 4;
  final context = SubwayOdyGlobalVariable.naviagatorState.currentContext as BuildContext;

  SubwayDividerAndNamePainter({
    required this.subwayList,
    required this.mainColor,
    required this.isSubwayDirectionLeft,
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
  void paint(Canvas canvas, Size size) {
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
          style: isSubwayDirectionLeft && index == 0 ||
                  !isSubwayDirectionLeft && index == subwayList.length - 1
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
