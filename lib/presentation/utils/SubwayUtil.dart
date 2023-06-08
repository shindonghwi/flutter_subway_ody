import 'package:flutter/cupertino.dart';
import 'package:subway_ody/presentation/constant/language.dart';
import 'package:subway_ody/presentation/constant/subway_1001.dart';
import 'package:subway_ody/presentation/constant/subway_1002.dart';
import 'package:subway_ody/presentation/constant/subway_1003.dart';
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

    debugPrint("findSubwayName: $nm");

    for (var info in subwayListFromHosun) {
      final statnName = info["statnName"].toString();

      if (subwayLine == "1호선") {
        if (nm.contains("도봉")) {
          if (nm == "도봉") {
            return "도봉";
          }
          return "도봉산";
        }
        if (nm.contains("동두천")) {
          if (nm == "동두천") {
            return "동두천";
          }
          return "동두천중앙";
        }
        if (nm == "평택지제") {
          return "지제";
        }
      }

      if (subwayLine == "2호선") {
        if (nm.contains("잠실")) {
          if (nm.contains("나루")) {
            return "잠실나루";
          } else if (nm.contains("새내")) {
            return "잠실새내";
          } else {
            return "잠실";
          }
        }
      }
      if (subwayLine == "4호선") {
        if (nm.contains("미아")) {
          if (nm == "미아") {
            return "미아";
          } else {
            return "미아사거리";
          }
        }
        if (nm.contains("동대문")) {
          if (nm == "동대문") {
            return "동대문";
          } else {
            return "동대문역사문화공원";
          }
        }
      }
      if (subwayLine == "6호선") {
        if (nm.contains("신내")) {
          if (nm == "신내") {
            return "신내";
          }
          return "연신내";
        }
      }
      if (subwayLine == "9호선") {
        if (nm.contains("석촌")) {
          if (nm == "석촌") {
            return "석촌";
          }
          return "석촌고분";
        }
      }
      if (subwayLine == "경춘선") {
        if (nm.contains("춘천")) {
          if (nm == "춘천") {
            return "춘천";
          }
          return "남춘천";
        }
      }
      if (subwayLine == "수인분당선") {
        if (nm.contains("수원")) {
          if (nm == "수원") {
            return "수원";
          }
          return "수원시청";
        }
        if (nm.contains("인천")) {
          if (nm == "인천") {
            return "인천";
          }
          return "인천논현";
        }
      }
      if (subwayLine == "신분당선") {
        if (nm.contains("논현")) {
          if (nm == "논현") {
            return "논현";
          }
          return "신논현";
        }
        if (nm.contains("양재")) {
          if (nm == "양재") {
            return "양재";
          }
          return "양재시민의숲";
        }
        if (nm.contains("광교")) {
          if (nm == "광교") {
            return "광교";
          }
          return "광교중앙";
        }
      }
      if (subwayLine == "우이신설선") {
        if (nm.contains("4.19")) {
          return statnName;
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
    required String destination,
    required bool isUp,
  }) {
    // 상행 여부
    final List<String> subwayNameList = [];
    Iterable<Map<String, String>> subwayList = [];

    List<Map<String, String>> newLines = [];

    debugPrint(
        "subwayId : $subwayId currentStatnId: $currentStatnId preStatnId: $preStatnId nextStatnId: $nextStatnId isUp: $isUp");

    /// 1호선
    if (subwayId == "1001") {
      int curIndex = subway1001Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int destinationName = subway1001Lines.indexWhere((map) => map["statnName"] == destination);
      debugPrint("asdsad curIndex : $curIndex destinationName: $destinationName");
      int count = 5;

      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        if (nextStatnId.compareTo("1001080142") >= 0 ||
            currentStatnId.compareTo("1001080142") >= 0) {
          int curIndex =
              subway1001ShinChangLines.indexWhere((map) => map["statnId"] == currentStatnId);
          int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
          subwayList = subway1001ShinChangLines.sublist(endIndex, curIndex + 1); // 아래꺼
        } else {
          int curIndex = subway1001Lines.indexWhere((map) => map["statnId"] == currentStatnId);
          int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
          subwayList = subway1001Lines.sublist(endIndex, curIndex + 1); // 아래꺼
        }
      } else {
        int guroIndex = subway1001Lines.indexWhere((map) => map["statnId"] == "1001000141");
        if (currentStatnId == "1001000141" && preStatnId == "1001000142") {
          // 구일에서 온 경우
          for (int i = guroIndex; i < subway1001Lines.length; i++) {
            newLines.add(subway1001Lines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          subwayList = newLines;
        } else if (currentStatnId == "1001000141" && preStatnId == "1001080142") {
          //가산디지털 단지에서 온 경우
          // 구일에서 온 경우
          int guroIndex =
              subway1001ShinChangLines.indexWhere((map) => map["statnId"] == "1001000141");
          for (int i = guroIndex; i < subway1001ShinChangLines.length; i++) {
            newLines.add(subway1001ShinChangLines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          subwayList = newLines;
        } else {
          if (currentStatnId.compareTo("1001000100") >= 0 &&
              currentStatnId.compareTo("1001000161") <= 0) {
            debugPrint("zxcxzc 222222 : }");
            int maxLength = subway1001Lines.length;
            int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
            subwayList = subway1001Lines.sublist(curIndex, endIndex + 1);
          } else if (currentStatnId.compareTo("1001080142") >= 0 &&
              currentStatnId.compareTo("1001080176") <= 0) {
            debugPrint("zxcxzc 333333 : }");
            int curIndex =
                subway1001ShinChangLines.indexWhere((map) => map["statnId"] == currentStatnId);
            subwayList = subway1001ShinChangLines.sublist(curIndex, curIndex + 5);
          } else {
            debugPrint("zxcxzc 44444 : }");
            int maxLength = subway1001ShinChangLines.length;
            int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
            subwayList = subway1001ShinChangLines.sublist(
                curIndex, endIndex > guroIndex ? guroIndex + 1 : endIndex + 1);
          }
        }
      }
    }

    /// 2호선
    else if (subwayId == "1002") {
      int curIndex = subway1002Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1002Lines.length;
      List<Map<String, String>> newLines = [];
      int count = 5;

      // 까치산 - 신도림
      if ((nextStatnId.compareTo("1002002341") >= 0 && nextStatnId.compareTo("1002002344") <= 0) ||
          (preStatnId.compareTo("1002002341") >= 0 && preStatnId.compareTo("1002002344") <= 0)) {
        if (nextStatnId.compareTo(currentStatnId) <= 0) {
          // 신설동행
          int curIndex = subway1002Out2Lines.indexWhere((map) => map["statnId"] == currentStatnId);

          for (int i = curIndex; i >= 0; i--) {
            newLines.add(subway1002Out2Lines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          subwayList = newLines;
        } else {
          int curIndex = subway1002Out2Lines.indexWhere((map) => map["statnId"] == currentStatnId);
          for (int i = curIndex; i < subway1002Out2Lines.length; i++) {
            newLines.add(subway1002Out2Lines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          subwayList = newLines.reversed;
        }
      }

      // 신설동 - 용답
      else if ((nextStatnId.compareTo("1002002111") >= 0 &&
              nextStatnId.compareTo("1002002114") <= 0) ||
          (preStatnId.compareTo("1002002111") >= 0 && preStatnId.compareTo("1002002114") <= 0)) {
        if (nextStatnId.compareTo(currentStatnId) <= 0) {
          // 신설동행
          int curIndex = subway1002Out1Lines.indexWhere((map) => map["statnId"] == currentStatnId);

          for (int i = curIndex; i >= 0; i--) {
            newLines.add(subway1002Out1Lines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          subwayList = newLines;
        } else {
          int curIndex = subway1002Out1Lines.indexWhere((map) => map["statnId"] == currentStatnId);
          for (int i = curIndex; i < subway1002Out1Lines.length; i++) {
            newLines.add(subway1002Out1Lines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          subwayList = newLines.reversed;
        }
      }
      // 내선
      else if (currentStatnId.compareTo("1002000201") >= 0 &&
          currentStatnId.compareTo("1002000243") <= 0) {
        if (isUp) {
          for (int i = curIndex; i < subway1002Lines.length; i++) {
            newLines.add(subway1002Lines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          if (newLines.length != 5) {
            for (int i = 0; i < subway1002Lines.length; i++) {
              newLines.add(subway1002Lines.elementAt(i));
              if (newLines.length == count) {
                break;
              }
            }
          }
          subwayList = newLines;
        } else {
          for (int i = curIndex; i >= 0; i--) {
            newLines.add(subway1002Lines.elementAt(i));
            if (newLines.length == count) {
              break;
            }
          }
          if (newLines.length != 5) {
            for (int i = subway1002Lines.length - 1; i >= 0; i--) {
              newLines.add(subway1002Lines.elementAt(i));
              if (newLines.length == count) {
                break;
              }
            }
          }
          subwayList = newLines.reversed;
        }
      }
    }

    /// 3호선
    else if (subwayId == "1003") {
      int curIndex = subway1003Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1003Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1003Lines.sublist(endIndex, curIndex + 1);
      } else {
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1003Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 4호선
    else if (subwayId == "1004") {
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
      int maxLength = subway1005Lines.length;
      int count = 5;

      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        debugPrint("zcxzxczxzcx :111111");

        if (currentStatnId.compareTo("1005000549") >= 0 &&
            currentStatnId.compareTo("1005000558") <= 0) {
          int curIndex = subway1005HanamLines.indexWhere((map) => map["statnId"] == currentStatnId);
          int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
          subwayList = subway1005HanamLines.sublist(endIndex, curIndex + 1);
        } else {
          int curIndex = subway1005Lines.indexWhere((map) => map["statnId"] == currentStatnId);
          int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
          subwayList = subway1005Lines.sublist(endIndex, curIndex + 1);
        }
      } else {
        if (preStatnId.compareTo("1005000549") >= 0 && preStatnId.compareTo("1005000558") <= 0) {
          int curIndex = subway1005HanamLines.indexWhere((map) => map["statnId"] == currentStatnId);
          int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
          subwayList = subway1005HanamLines.sublist(curIndex, endIndex + 1);
        } else {
          int curIndex = subway1005Lines.indexWhere((map) => map["statnId"] == currentStatnId);
          int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
          subwayList = subway1005Lines.sublist(curIndex, endIndex + 1);
        }
      }
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
      if (!isUp) {
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1008Lines.sublist(endIndex, curIndex + 1);
      } else {
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1008Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 9호선
    else if (subwayId == "1009") {
      int curIndex = subway1009Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1009Lines.length;
      if (!isUp) {
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1009Lines.sublist(endIndex, curIndex + 1);
      } else {
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1009Lines.sublist(curIndex, endIndex + 1);
      }
    }

    /// 공항철도
    else if (subwayId == "1065") {
      int curIndex = subway1065Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1065Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        // 청라 국제도시 -> 서울
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1065Lines.sublist(curIndex, endIndex + 1).reversed;
      } else {
        // 서울 -> 청라 국제도시
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1065Lines.sublist(endIndex, curIndex + 1).reversed;
      }
    }

    /// 신분당선
    else if (subwayId == "1077") {
      int curIndex = subway1077Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1077Lines.length;
      if (currentStatnId.compareTo(preStatnId) >= 0 && currentStatnId.compareTo(nextStatnId) <= 0) {
        // 광교 -> 신사
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1077Lines.sublist(endIndex, curIndex + 1);
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
      if (isUp) {
        // 신설동 -> 북한산우이
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1092Lines.sublist(curIndex, endIndex + 1);
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
      if (isUp) {
        // 인천 -> 청량리
        int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
        subwayList = subway1075Lines.sublist(curIndex, endIndex + 1);
      } else {
        // 청량리 -> 인천
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        debugPrint("curIndex : $curIndex || $endIndex");
        subwayList = subway1075Lines.sublist(endIndex, curIndex + 1);
      }
    }

    /// 경춘선
    else if (subwayId == "1067") {
      int curIndex = subway1067Lines.indexWhere((map) => map["statnId"] == currentStatnId);
      int maxLength = subway1067Lines.length;
      // 상봉 - 광운대
      if (currentStatnId == "1067080120" && nextStatnId == "1067080119") {
        subwayList = subway1067GwangWunLines.reversed;
      }
      // 광운대 -> 상봉행
      else if (currentStatnId == "1067080119" && nextStatnId == "1067080120") {
        subwayList = subway1067GwangWunLines;
      } else if (isUp) {
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
      }else if (isUp) {
        int endIndex = curIndex - 4 < 0 ? 0 : curIndex - 4;
        subwayList = subway1063Lines.sublist(endIndex, curIndex + 1).reversed;
      } else {
        if (currentStatnId.compareTo("1063075335") >= 0){ // 문산이 종점 예외처리
          newLines.add(subway1063Lines.elementAt(subway1063Lines.indexWhere((map) => map["statnId"] == "1063075335")));
          subwayList = newLines.toList();
        }else{
          int endIndex = curIndex + 4 > maxLength - 1 ? maxLength - 1 : curIndex + 4;
          subwayList = subway1063Lines.sublist(curIndex, endIndex + 1).reversed;
        }
      }

    }
    for (var element in subwayList) {
      subwayNameList.add(element["statnName"].toString());
    }
    return subwayNameList.toList();
  }
}
