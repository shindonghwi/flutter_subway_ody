import 'package:flutter/cupertino.dart';
import 'package:subway_ody/presentation/constant/subway.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SubwayUtil {
  /// 1001:1호선 1002:2호선 1003:3호선, 1004:4호선,1005:5호선, 1006:6호선,1007:7호선, 1008:8호선, 1009:9호선,
  /// 1063:경의중앙선, 1065:공항철도, 1067:경춘선, 1075:수의분당선 1077:신분당선, 1092:우이신설선
  static Color getMainColor(BuildContext context, String subwayLine) {
    if (subwayLine == "1001") {
      return getColorScheme(context).colorLine1;
    } else if (subwayLine.contains("1002")) {
      return getColorScheme(context).colorLine2;
    } else if (subwayLine.contains("1003")) {
      return getColorScheme(context).colorLine3;
    } else if (subwayLine.contains("1004")) {
      return getColorScheme(context).colorLine4;
    } else if (subwayLine.contains("1005")) {
      return getColorScheme(context).colorLine5;
    } else if (subwayLine.contains("1006")) {
      return getColorScheme(context).colorLine6;
    } else if (subwayLine.contains("1007")) {
      return getColorScheme(context).colorLine7;
    } else if (subwayLine.contains("1008")) {
      return getColorScheme(context).colorLine8;
    } else if (subwayLine.contains("9호선")) {
      return getColorScheme(context).colorLine9;
    } else if (subwayLine.contains("1063")) {
      return getColorScheme(context).colorLineGyeonguiCentral;
    } else if (subwayLine.contains("1065")) {
      return getColorScheme(context).colorLineAirportRailroad;
    } else if (subwayLine.contains("1067")) {
      return getColorScheme(context).colorLineGyeongchun;
    } else if (subwayLine.contains("1075")) {
      return getColorScheme(context).colorLineSuinBundang;
    } else if (subwayLine.contains("1077")) {
      return getColorScheme(context).colorLineNewParty;
    } else if (subwayLine.contains("1092")) {
      return getColorScheme(context).colorLineNewUisun;
    }

    return const Color(0xFFB6B6B6);
  }

  static String parseSubwayHoSun(String subwayName) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    if (isNumeric(subwayName[0])) {
      return subwayName[0];
    } else {
      return subwayName;
    }
  }

  static List<String> findSubwayNameList({
    required String subwayId,
    required String currentSubwayId,
    required String preSubwayId,
    required String nextSubwayId,
    required bool isUp,
  }) {
    // 상행 여부
    final List<String> subwayNameList = [];

    List<Map<String, String>> subwayListFromHosun =
    realtimeSubwayInfo.where((element) => element["subwayId"] == subwayId).toList();

    // x호선 데이터 정보
    final Map<String, Map<String, String>> subwayInfoMap = {}; // Map<호선, 지하철정보>
    for (var info in subwayListFromHosun) {
      subwayInfoMap[info["statnId"].toString()] = {
        "subwayId": info["subwayId"].toString(),
        "statnName": info["statnName"].toString(),
        "hosunName": info["hosunName"].toString(),
      };
    }

    if (subwayInfoMap.containsKey(currentSubwayId)) {
      List<MapEntry<String, Map<String, String>>> entries = subwayInfoMap.entries.toList();
      int currentIndex = entries.indexWhere((entry) => entry.key == currentSubwayId);

      if (currentIndex != -1) {

        List<MapEntry<String, Map<String, String>>> nextEntries;
        int endIndex = currentIndex - 4 < 0 ? 0 : currentIndex - 4;
        if (!isUp) {
          nextEntries = entries.sublist(endIndex, currentIndex + 1).toList();
          debugPrint("isUp nextEntries: $nextEntries");
        } else {
          endIndex = currentIndex + 4 > entries.length - 1 ? entries.length - 1 : currentIndex + 4;
          nextEntries = entries.sublist(currentIndex, endIndex + 1);
          debugPrint("!isUp nextEntries: $nextEntries");
        }

        for (var entry in nextEntries) {
          Map<String, String> nextValue = entry.value;
          subwayNameList.add(nextValue["statnName"].toString());
        }
      } else {
        // print("currentSubwayId를 찾을 수 없습니다.");
      }
    } else {
      // print("currentSubwayId가 subwayInfoMap에 없습니다.");
    }

    if (!isUp){
      return subwayNameList.reversed.toList();
    }else{
      return subwayNameList;
    }
  }
}
