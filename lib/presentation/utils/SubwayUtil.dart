import 'package:flutter/cupertino.dart';
import 'package:subway_ody/presentation/constant/language.dart';
import 'package:subway_ody/presentation/constant/subway_1004.dart';
import 'package:subway_ody/presentation/constant/subway_1005.dart';
import 'package:subway_ody/presentation/constant/subway_1006.dart';
import 'package:subway_ody/presentation/constant/subway_1007.dart';
import 'package:subway_ody/presentation/constant/subway_1008.dart';
import 'package:subway_ody/presentation/constant/subway_1009.dart';
import 'package:subway_ody/presentation/constant/subway_1063.dart';
import 'package:subway_ody/presentation/constant/subway_1065.dart';
import 'package:subway_ody/presentation/constant/subway_1067.dart';
import 'package:subway_ody/presentation/constant/subway_1075.dart';
import 'package:subway_ody/presentation/constant/subway_1077.dart';
import 'package:subway_ody/presentation/constant/subway_1092.dart';
import 'package:subway_ody/presentation/constant/subway_all.dart';
import 'package:subway_ody/presentation/feature/setting/models/LanguageType.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SubwayUtil {
  /// 1001:1호선 1002:2호선 1003:3호선, 1004:4호선,1005:5호선, 1006:6호선,1007:7호선, 1008:8호선, 1009:9호선,
  /// 1063:경의중앙선, 1065:공항철도, 1067:경춘선, 1075:수인분당선 1077:신분당선, 1092:우이신설선
  static Color getMainColor(BuildContext context, String subwayLine) {
    debugPrint("@@@@ subwayLine: $subwayLine");
    if (subwayLine.contains("1호선")) {
      return getColorScheme(context).colorLine1;
    } else if (subwayLine.contains("2호선")) {
      return getColorScheme(context).colorLine2;
    } else if (subwayLine.contains("3호선")) {
      return getColorScheme(context).colorLine3;
    } else if (subwayLine.contains("4호선")) {
      return getColorScheme(context).colorLine4;
    } else if (subwayLine.contains("5호선")) {
      return getColorScheme(context).colorLine5;
    } else if (subwayLine.contains("6호선")) {
      return getColorScheme(context).colorLine6;
    } else if (subwayLine.contains("7호선")) {
      return getColorScheme(context).colorLine7;
    } else if (subwayLine.contains("8호선")) {
      return getColorScheme(context).colorLine8;
    } else if (subwayLine.contains("9호선")) {
      return getColorScheme(context).colorLine9;
    } else if (subwayLine.contains("경의중앙")) {
      return getColorScheme(context).colorLineGyeonguiCentral;
    } else if (subwayLine.contains("공항철도")) {
      return getColorScheme(context).colorLineAirportRailroad;
    } else if (subwayLine.contains("경춘")) {
      return getColorScheme(context).colorLineGyeongchun;
    } else if (subwayLine.contains("수인분당")) {
      return getColorScheme(context).colorLineSuinBundang;
    } else if (subwayLine.contains("신분당")) {
      return getColorScheme(context).colorLineNewParty;
    } else {
      // 우이신설
      return getColorScheme(context).colorLineNewUisun;
    }
  }

  /// 1001:1호선 1002:2호선 1003:3호선, 1004:4호선,1005:5호선, 1006:6호선,1007:7호선, 1008:8호선, 1009:9호선,
  /// 1063:경의중앙선, 1065:공항철도, 1067:경춘선, 1075:수인분당선 1077:신분당선, 1092:우이신설선
  static String getSubwayHosun(String subwayLine) {
    if (subwayLine.contains("1호선")) {
      return "1";
    } else if (subwayLine.contains("2호선")) {
      return "2";
    } else if (subwayLine.contains("3호선")) {
      return "3";
    } else if (subwayLine.contains("4호선")) {
      return "4";
    } else if (subwayLine.contains("5호선")) {
      return "5";
    } else if (subwayLine.contains("6호선")) {
      return "6";
    } else if (subwayLine.contains("7호선")) {
      return "7";
    } else if (subwayLine.contains("8호선")) {
      return "8";
    } else if (subwayLine.contains("9호선")) {
      return "9";
    } else {
      return subwayLine;
    }
  }

  static String subwayLineToId(String subwayLine) {
    if (subwayLine.contains("1호선")) {
      return "1001";
    } else if (subwayLine.contains("2호선")) {
      return "1002";
    } else if (subwayLine.contains("3호선")) {
      return "1003";
    } else if (subwayLine.contains("4호선")) {
      return "1004";
    } else if (subwayLine.contains("5호선")) {
      return "1005";
    } else if (subwayLine.contains("6호선")) {
      return "1006";
    } else if (subwayLine.contains("7호선")) {
      return "1007";
    } else if (subwayLine.contains("8호선")) {
      return "1008";
    } else if (subwayLine.contains("9호선")) {
      return "1009";
    } else if (subwayLine.contains("경의중앙")) {
      return "1063";
    } else if (subwayLine.contains("공항철도")) {
      return "1065";
    } else if (subwayLine.contains("경춘선")) {
      return "1067";
    } else if (subwayLine.contains("수인분당선")) {
      return "1075";
    } else if (subwayLine.contains("신분당선")) {
      return "1077";
    } else {
      return "1092";
    }
  }

  static String findSubwayName({
    required String subwayName,
    required String subwayLine,
  }) {
    List<Map<String, String>> subwayListFromHosun =
        realtimeSubwayInfo.where((element) => element["hosunName"]!.contains(subwayLine)).toList();

    final nm = subwayName.trim().endsWith("역")
        ? subwayName.trim().substring(0, subwayName.length - 1)
        : subwayName;

    for (var info in subwayListFromHosun) {
      final statnName = info["statnName"].toString();

      if (subwayLine == "6호선") {
        if (statnName.contains("신내")) {
          if (nm == "신내") {
            return "신내";
          }
          return "연신내";
        }
      }

      final a = statnName.contains(nm);
      final b = nm.contains(statnName);

      if (a && b) {
        return nm;
      }
      if (a || b) {
        return statnName;
      }
    }
    return "";
  }

  static String findLanguageSubwayName(
    String targetValue, {
    bool isDestination = false,
    bool isPositionData = false,
    required LanguageType languageType,
  }) {
    if (languageType == LanguageType.KOR) {
      return targetValue;
    }

    var value = targetValue.replaceAll("방면", "").split("(").first;

    // 전처리
    if (isDestination) {
      value = value.endsWith("행") ? value.substring(0, value.length - 1) : value;
    }

    String? findText = targetValue;
    for (var mapData in languageData) {
      if (value == (mapData["station_nm"].toString().split("(").first)) {
        if (LanguageType.ENG == languageType) {
          findText = mapData["station_nm_eng"];
        } else if (LanguageType.CHN == languageType) {
          findText = mapData["station_nm_chn"];
        } else if (LanguageType.JPN == languageType) {
          findText = mapData["station_nm_jpn"];
        }
        if (findText.toString().isEmpty) {
          findText = mapData["station_nm"];
        }
        break;
      }
    }

    // 후처리
    if (isDestination && !isPositionData) {
      if (LanguageType.ENG == languageType) {
        findText = "Towards $findText";
      } else if (LanguageType.CHN == languageType) {
        findText = "$findText方面";
      } else if (LanguageType.JPN == languageType) {
        findText = "$findTextほうめん";
      }
    }

    return findText ?? targetValue;
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
    Iterable<Map<String, String>> subwayList = [];

    List<Map<String, String>> newLines = [];

    /// 4호선
    if (subwayId == "1004") {
      int curIndex = subway1004Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1004Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1004Lines.sublist(endIndex, curIndex + 1);
      } else {
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1004Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 5호선
    else if (subwayId == "1005") {
      int curIndex = subway1005Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1005Lines.length;
    }

    /// 6호선
    else if (subwayId == "1006") {
      int curIndex = subway1006Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1006Lines.length;

      // 응암역에서 역촌 ~ 구산 사이인 경우
      if (preStatnId.compareTo("1006000615") <= 0 && currentStatnId == nextStatnId) {
        newLines.add(subway1006Lines.elementAt(curIndex));
        for (int i = 6; i < 10; i++) {
          newLines.add(subway1006Lines.elementAt(curIndex + i));
        }
        subwayList = newLines;
      } else if (currentStatnId == "1006000610" && preStatnId.compareTo("1006000615") <= 0) {
        newLines.add(subway1006Lines.elementAt(curIndex));
        for (int i = 5; i > 1; i--) {
          newLines.add(subway1006Lines.elementAt(curIndex + i));
        }
        subwayList = newLines.reversed;
      } else if (currentStatnId.compareTo(preStatnId) >= 0 &&
          currentStatnId.compareTo(nextStatnId) <= 0) {
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1006Lines.sublist(endIndex, curIndex + 1);
      } else {
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1006Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 7호선
    else if (subwayId == "1007") {
      int curIndex = subway1007Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1007Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        //
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1007Lines.sublist(endIndex, curIndex + 1);
      } else {
        //
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1007Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 8호선
    else if (subwayId == "1008") {
      int curIndex = subway1008Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1008Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        //
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1008Lines.sublist(endIndex, curIndex + 1);
      } else {
        //
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1008Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 9호선
    else if (subwayId == "1009") {
      int curIndex = subway1009Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1009Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        //
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1009Lines.sublist(endIndex, curIndex + 1);
      } else {
        //
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1009Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 공항철도
    else if (subwayId == "1065") {
      int curIndex = subway1065Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1065Lines.length;
      if (currentStatnId.compareTo(preStatnId) < 0) {
        // 서울 -> 청라 국제도시
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1065Lines.sublist(endIndex, curIndex + 1);
      } else {
        // 청라 국제도시 -> 서울
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1065Lines.sublist(curIndex, endIndex + 1).reversed;
      }
    }

    /// 신분당선
    else if (subwayId == "1077") {
      int curIndex = subway1077Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1077Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0) {
        // 광교 -> 신사
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1077Lines.sublist(endIndex, curIndex + 1).reversed;
      } else {
        // 신사 -> 광교
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1077Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 우이신설선
    else if (subwayId == "1092") {
      int curIndex = subway1092Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1092Lines.length;
      if (currentStatnId.compareTo(nextStatnId) < 0) {
        // 신설동 -> 북한산우이
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1092Lines.sublist(curIndex, endIndex + 1).reversed;
      } else {
        // 북한산우이 -> 신설동
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1092Lines.sublist(endIndex, curIndex + 1);
      }
    }

    /// 수인분당선
    else if (subwayId == "1075") {
      int curIndex = subway1075Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1075Lines.length;
      if (currentStatnId.compareTo(nextStatnId) >= 0) {
        // 인천 -> 청량리
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1075Lines.sublist(curIndex, endIndex + 1);
      } else {
        // 청량리 -> 인천
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1075Lines.sublist(endIndex, curIndex + 1);
      }
    }

    /// 경춘선
    else if (subwayId == "1067") {
      int curIndex = subway1067Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1067Lines.length;

      // 상봉 - 광운대
      if (currentStatnId == "1067080120" && nextStatnId == "1067080119") {
        subwayList = subway1067Lines.sublist(curIndex - 1, curIndex + 1).reversed;
      }
      // 광운대 -> 상봉행
      else if (currentStatnId == "1067080119" && nextStatnId == "1067080120") {
        subwayList = subway1067Lines.sublist(curIndex, curIndex + 2);
      } else if (currentStatnId.compareTo(nextStatnId) >= 0) {
        // 춘천 -> 청량리
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1067Lines.sublist(curIndex, endIndex + 1);
      } else {
        // 청량리 -> 춘천
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1067Lines.sublist(endIndex, curIndex + 1);
      }
    }

    /// 경의중앙선
    else if (subwayId == "1063") {
      int curIndex = subway1063Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1063Lines.length;

      // 가좌 -> 신촌
      if (currentStatnId == "1063075315") {
        int seoulIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063080313");
        int gajwaIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063075315");
        int sinchoneIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063080312");
        if (preStatnId == "1063080312") {
          // 이전역이 신촌
          newLines.add(subway1063Lines.elementAt(gajwaIndex));
          newLines.add(subway1063Lines.elementAt(sinchoneIndex));
          newLines.add(subway1063Lines.elementAt(seoulIndex));
        } else if (currentStatnId.compareTo(nextStatnId) < 0) {
          int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
          subwayList = subway1063Lines.sublist(endIndex, curIndex + 1).reversed;
        } else {
          int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
          subwayList = subway1063Lines.sublist(curIndex, endIndex + 1).reversed;
        }
      }
      // 신촌
      else if (currentStatnId == "1063080312") {
        int seoulIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063080313");
        int gajwaIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063075315");
        int sinchoneIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063080312");
        if (currentStatnId.compareTo(nextStatnId) >= 0) {
          newLines.add(subway1063Lines.elementAt(sinchoneIndex));
          newLines.add(subway1063Lines.elementAt(seoulIndex));
          subwayList = newLines.toList();
        } else {
          newLines.add(subway1063Lines.elementAt(sinchoneIndex));
          newLines.add(subway1063Lines.elementAt(gajwaIndex));
          subwayList = newLines.toList().reversed.toList();
        }
      }
      // 서울
      else if (currentStatnId == "1063080313") {
        int seoulIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063080313");
        int gajwaIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063075315");
        int sinchoneIndex = subway1063Lines.indexWhere((map) => map["statnId"] == "1063080312");
        if (currentStatnId.compareTo(nextStatnId) > 0) {
          Iterable<Map<String, String>> newLines = [
            subway1063Lines.elementAt(seoulIndex),
          ];
          subwayList = newLines.toList();
        } else {
          Iterable<Map<String, String>> newLines = [
            subway1063Lines.elementAt(seoulIndex),
            subway1063Lines.elementAt(sinchoneIndex),
            subway1063Lines.elementAt(gajwaIndex),
          ];
          subwayList = newLines.toList().reversed.toList();
        }
      } else if (currentStatnId.compareTo(nextStatnId) > 0) {
        // 춘천 -> 청량리
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1063Lines.sublist(curIndex, endIndex + 1).reversed;
        subwayList =
            subwayList.where((map) => map["statnId"].toString().compareTo("1063080312") < 0);
      } else {
        // 청량리 -> 춘천
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1063Lines.sublist(endIndex, curIndex + 1).reversed;
        subwayList =
            subwayList.where((map) => map["statnId"].toString().compareTo("1063080312") < 0);
      }
    } else {}

    for (var element in subwayList) {
      subwayNameList.add(element["statnName"].toString());
    }
    return subwayNameList.toList();
  }
}
