import 'package:flutter/cupertino.dart';
import 'package:subway_ody/presentation/constant/subway.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SubwayUtil {
  /// 1001:1호선 1002:2호선 1003:3호선, 1004:4호선,1005:5호선, 1006:6호선,1007:7호선, 1008:8호선, 1009:9호선,
  /// 1063:경의중앙선, 1065:공항철도, 1067:경춘선, 1075:수인분당선 1077:신분당선, 1092:우이신설선
  static Color getMainColor(BuildContext context, String subwayLine) {
    debugPrint("@@@@ subwayLine: $subwayLine");
    if (subwayLine.contains("1호선")) {
      return getColorScheme(context).colorLine1;
    }else if(subwayLine.contains("2호선")) {
      return getColorScheme(context).colorLine2;
    }else if(subwayLine.contains("3호선")) {
      return getColorScheme(context).colorLine3;
    }else if(subwayLine.contains("4호선")) {
      return getColorScheme(context).colorLine4;
    }else if(subwayLine.contains("5호선")) {
      return getColorScheme(context).colorLine5;
    }else if(subwayLine.contains("6호선")) {
      return getColorScheme(context).colorLine6;
    }else if(subwayLine.contains("7호선")) {
      return getColorScheme(context).colorLine7;
    }else if(subwayLine.contains("8호선")) {
      return getColorScheme(context).colorLine8;
    }else if(subwayLine.contains("9호선")) {
      return getColorScheme(context).colorLine9;
    }else if(subwayLine.contains("경의중앙")) {
      return getColorScheme(context).colorLineGyeonguiCentral;
    } else if (subwayLine.contains("공항철도")) {
      return getColorScheme(context).colorLineAirportRailroad;
    } else if (subwayLine.contains("경춘")) {
      return getColorScheme(context).colorLineGyeongchun;
    } else if (subwayLine.contains("수인분당")) {
      return getColorScheme(context).colorLineSuinBundang;
    } else if (subwayLine.contains("신분당")) {
      return getColorScheme(context).colorLineNewParty;
    } else { // 우이신설
      return getColorScheme(context).colorLineNewUisun;
    }
  }

  /// 1001:1호선 1002:2호선 1003:3호선, 1004:4호선,1005:5호선, 1006:6호선,1007:7호선, 1008:8호선, 1009:9호선,
  /// 1063:경의중앙선, 1065:공항철도, 1067:경춘선, 1075:수인분당선 1077:신분당선, 1092:우이신설선
  static String getSubwayHosun(String subwayLine) {
    if (subwayLine.contains("1호선")) {
      return "1";
    }else if(subwayLine.contains("2호선")) {
      return "2";
    }else if(subwayLine.contains("3호선")) {
      return "3";
    }else if(subwayLine.contains("4호선")) {
      return "4";
    }else if(subwayLine.contains("5호선")) {
      return "5";
    }else if(subwayLine.contains("6호선")) {
      return "6";
    }else if(subwayLine.contains("7호선")) {
      return "7";
    }else if(subwayLine.contains("8호선")) {
      return "8";
    }else if(subwayLine.contains("9호선")) {
      return "9";
    }else{
      return subwayLine;
    }
  }

  static String subwayLineToId(String subwayLine) {
    if (subwayLine.contains("1호선")) {
      return "1001";
    }else if(subwayLine.contains("2호선")) {
      return "1002";
    }else if(subwayLine.contains("3호선")) {
      return "1003";
    }else if(subwayLine.contains("4호선")) {
      return "1004";
    }else if(subwayLine.contains("5호선")) {
      return "1005";
    }else if(subwayLine.contains("6호선")) {
      return "1006";
    }else if(subwayLine.contains("7호선")) {
      return "1007";
    }else if(subwayLine.contains("8호선")) {
      return "1008";
    }else if(subwayLine.contains("9호선")) {
      return "1009";
    }else if(subwayLine.contains("경의중앙")) {
      return "1063";
    }else if(subwayLine.contains("공항철도")) {
      return "1065";
    }else if(subwayLine.contains("경춘선")) {
      return "1067";
    }else if(subwayLine.contains("수인분당선")) {
      return "1075";
    }else if(subwayLine.contains("신분당선")) {
      return "1077";
    }else{
      return "1092";
    }
  }

  static String findSubwayName({
    required String subwayName,
    required String subwayLine,
  }) {
    List<Map<String, String>> subwayListFromHosun = realtimeSubwayInfo
        .where((element) => element["hosunName"]!.contains(subwayLine))
        .toList();

    final nm = subwayName.trim().endsWith("역")
        ? subwayName.trim().substring(0, subwayName.length - 1)
        : subwayName;

    for (var info in subwayListFromHosun) {
      final statnName = info["statnName"].toString();
      final a = statnName.contains(nm);
      final b = nm.contains(statnName);

      if (a || b){
        return statnName;
      }
    }
    return "";
  }

  static List<String> findSubwayNameList({
    required String subwayId,
    required String currentStatnId,
    required String preStatnId,
    required String nextStatnId,
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

    if (subwayInfoMap.containsKey(currentStatnId)) {
      List<MapEntry<String, Map<String, String>>> entries =
          subwayInfoMap.entries.toList();
      int currentIndex = entries.indexWhere((entry) => entry.key == currentStatnId);

      if (currentIndex != -1) {
        List<MapEntry<String, Map<String, String>>> nextEntries;
        int endIndex = currentIndex - 4 < 0 ? 0 : currentIndex - 4;
        if (!isUp) {
          nextEntries = entries.sublist(endIndex, currentIndex + 1).toList();
          // debugPrint("isUp nextEntries: $nextEntries");
        } else {
          endIndex = currentIndex + 4 > entries.length - 1
              ? entries.length - 1
              : currentIndex + 4;
          nextEntries = entries.sublist(currentIndex, endIndex + 1);
          // debugPrint("!isUp nextEntries: $nextEntries");
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
    return subwayNameList.toList();
  }
}
