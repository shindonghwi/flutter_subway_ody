import 'package:flutter/material.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/SystemUtil.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';
import 'package:subway_ody/presentation/utils/dto/Triple.dart';

/// 지하철 방향 및 도착 예정 시간
class SubwayDirectionETA extends StatelessWidget {
  final SubwayDirectionStationModel stationInfo;

  const SubwayDirectionETA({
    super.key,
    required this.stationInfo,
  });

  @override
  Widget build(BuildContext context) {
    LanguageType type = SystemUtil.getLanguageType(SubwayOdyApp.currentLocale);
    final nextStation = SubwayUtil.findLanguageSubwayName(
      stationInfo.nextStation,
      languageType: type,
    );

    final destination = SubwayUtil.findLanguageSubwayName(stationInfo.destination,
        isDestination: true, languageType: type);

    var languageUpdnLine = parserUpdnLine(stationInfo.updnLine, type);
    var languageArvlMsg2 = parserArvlMsg2(stationInfo.arvlMsg2, type);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "$nextStation - $languageUpdnLine",
              style: getTextTheme(context).medium.copyWith(
                    color: const Color(0xFF2F2F2F),
                    fontSize: 14,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              destination,
              style: getTextTheme(context).medium.copyWith(
                    color: const Color(0xFF676767),
                    fontSize: 12,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),

        /// 여기 아래는 도착예정 정보가 있으면 표시
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: getColorScheme(context).white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: getColorScheme(context).colorPrimary,
              width: 1,
            ),
          ),
          child: Text(
            languageArvlMsg2,
            style: getTextTheme(context).bold.copyWith(
                  color: getColorScheme(context).colorPrimary,
                  fontSize: 12,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  String parserUpdnLine(String updnLine, LanguageType type) {
    var languageUpdnLine = updnLine;
    if (type == LanguageType.ENG) {
      if (languageUpdnLine == "상행") {
        languageUpdnLine = "up";
      } else if (languageUpdnLine == "하행") {
        languageUpdnLine = "down";
      } else if (languageUpdnLine == "외선") {
        languageUpdnLine = "external";
      } else if (languageUpdnLine == "내선") {
        languageUpdnLine = "extension";
      }
    } else if (type == LanguageType.JPN) {
      if (languageUpdnLine == "상행") {
        languageUpdnLine = "上り";
      } else if (languageUpdnLine == "하행") {
        languageUpdnLine = "は行";
      } else if (languageUpdnLine == "외선") {
        languageUpdnLine = "外線";
      } else if (languageUpdnLine == "내선") {
        languageUpdnLine = "内線";
      }
    } else if (type == LanguageType.CHN) {
      if (languageUpdnLine == "상행") {
        languageUpdnLine = "上行";
      } else if (languageUpdnLine == "하행") {
        languageUpdnLine = "下行";
      } else if (languageUpdnLine == "외선") {
        languageUpdnLine = "外线";
      } else if (languageUpdnLine == "내선") {
        languageUpdnLine = "内线";
      }
    }
    return languageUpdnLine;
  }

  String parserArvlMsg2(String msg, LanguageType type) {
    var languageMsg = msg;

    String parseContainTimeMinuteDestination() {
      final destination =
          languageMsg.split(" ").last.replaceAll("(", "").replaceAll(")", "");
      final languageDestination = SubwayUtil.findLanguageSubwayName(
        destination,
        languageType: type,
      );
      return languageDestination;
    }

    Pair<String, String> parseContainTimeMinuteSecondDestination() {
      String minute = "-";
      String second = "-";
      languageMsg.split(" ").forEach((element) {
        if (element.contains("분")) {
          minute = element.substring(0, 1);
        } else if (element.contains("초")) {
          second = element.substring(0, 1);
        }
      });
      return Pair(minute, second);
    }

    if (type == LanguageType.ENG) {
      if (languageMsg == "전역 도착") {
        languageMsg = "Arrival at this station";
      } else if (languageMsg == "전역 출발") {
        languageMsg = "Departure from this station";
      } else if (languageMsg == "전역 진입") {
        languageMsg = "Entering this station";
      } else if (languageMsg.contains("분 후")) {
        final time = languageMsg.split(" ").join().substring(0, 1);
        languageMsg = "$time${"min"} later (${parseContainTimeMinuteDestination()})";
      } else if (languageMsg.contains("분") &&
          languageMsg.contains("초") &&
          languageMsg.contains("후")) {
        Pair<String, String> minSecond = parseContainTimeMinuteSecondDestination();
        languageMsg = "${minSecond.first}min ${minSecond.second}sec later";
      } else if (languageMsg.contains("전전역")) {
        if (languageMsg.contains("도착")){
          languageMsg = "Arrival from 2 previous station";
        } else if (languageMsg.contains("출발")){
          languageMsg = "Departure from 2 previous station";
        } else if (languageMsg.contains("진입")){
          languageMsg = "Entering from 2 previous station";
        }
      } else if (languageMsg.split(" ").length == 2) {
        final destination = SubwayUtil.findLanguageSubwayName(
          languageMsg.split(" ").first,
          languageType: type,
        );
        String afterMsg = "";
        if (languageMsg.contains("도착")){
          afterMsg = "Arrival";
        } else if (languageMsg.contains("출발")){
          afterMsg = "Departure";
        } else if (languageMsg.contains("진입")){
          afterMsg = "Entering";
        }
        languageMsg = "$destination $afterMsg";
      }
    } else if (type == LanguageType.JPN) {
      if (languageMsg == "전역 도착") {
        languageMsg = "前駅到着";
      } else if (languageMsg == "전역 출발") {
        languageMsg = "前駅発着";
      } else if (languageMsg == "전역 진입") {
        languageMsg = "移転駅進入";
      } else if (languageMsg.contains("분 후")) {
        final time = languageMsg.split(" ").join().substring(0, 1);
        languageMsg = "$time分のち(${parseContainTimeMinuteDestination()})";
      } else if (languageMsg.contains("분") &&
          languageMsg.contains("초") &&
          languageMsg.contains("후")) {
        Pair<String, String> minSecond = parseContainTimeMinuteSecondDestination();
        languageMsg = "${minSecond.first}ふん ${minSecond.second}びょう ご";
      } else if (languageMsg.contains("전전역")) {
        if (languageMsg.contains("도착")){
          languageMsg = "前の2駅からの到着";
        } else if (languageMsg.contains("출발")){
          languageMsg = "前の2駅からの出発";
        } else if (languageMsg.contains("진입")){
          languageMsg = "2 前の駅から入る";
        }
      } else if (languageMsg.split(" ").length == 2) {
        final destination = SubwayUtil.findLanguageSubwayName(
          languageMsg.split(" ").first,
          languageType: type,
        );
        String afterMsg = "";
        if (languageMsg.contains("도착")){
          afterMsg = "到着";
        } else if (languageMsg.contains("출발")){
          afterMsg = "出発";
        } else if (languageMsg.contains("진입")){
          afterMsg = "入力";
        }
        languageMsg = "$destination $afterMsg";
      }
    } else if (type == LanguageType.CHN) {
      if (languageMsg == "전역 도착") {
        languageMsg = "到达前一站";
      } else if (languageMsg == "전역 출발") {
        languageMsg = "前站出发";
      } else if (languageMsg == "전역 진입") {
        languageMsg = "进入该区域";
      } else if (languageMsg.contains("분 후")) {
        final time = languageMsg.split(" ").join().substring(0, 1);
        languageMsg = "$time分钟后(${parseContainTimeMinuteDestination()})";
      } else if (languageMsg.contains("분") &&
          languageMsg.contains("초") &&
          languageMsg.contains("후")) {
        Pair<String, String> minSecond = parseContainTimeMinuteSecondDestination();
        languageMsg = "${minSecond.first}分 ${minSecond.second}秒 后";
      } else if (languageMsg.contains("전전역")) {
        if (languageMsg.contains("도착")){
          languageMsg = "由前两站到达";
        } else if (languageMsg.contains("출발")){
          languageMsg = "由前两站开出";
        } else if (languageMsg.contains("진입")){
          languageMsg = "由前两站进入";
        }
      } else if (languageMsg.split(" ").length == 2) {
        final destination = SubwayUtil.findLanguageSubwayName(
          languageMsg.split(" ").first,
          languageType: type,
        );
        String afterMsg = "";
        if (languageMsg.contains("도착")){
          afterMsg = "抵达";
        } else if (languageMsg.contains("출발")){
          afterMsg = "离境";
        } else if (languageMsg.contains("진입")){
          afterMsg = "进入";
        }
        languageMsg = "$destination $afterMsg";
      }
    }
    return languageMsg;
  }
}
