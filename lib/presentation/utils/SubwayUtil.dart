import 'package:flutter/cupertino.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SubwayUtil{

  /// 1호선, 2호선, 3호선, 4호선, 5호선, 6호선, 7호선, 8호선, 9호선,
  /// 중앙선, 경의중앙선, 공항철도, 경춘선, 수인분당선 신분당선, 우이신설선
  static Color getMainColor(BuildContext context, String subwayLine){

    if (subwayLine == "1호선"){
      return getColorScheme(context).colorLine1;
    } else if (subwayLine.contains("2호선")){
      return getColorScheme(context).colorLine2;
    } else if (subwayLine.contains("3호선")){
      return getColorScheme(context).colorLine3;
    } else if (subwayLine.contains("4호선")){
      return getColorScheme(context).colorLine4;
    } else if (subwayLine.contains("5호선")){
      return getColorScheme(context).colorLine5;
    } else if (subwayLine.contains("6호선")){
      return getColorScheme(context).colorLine6;
    } else if (subwayLine.contains("7호선")){
      return getColorScheme(context).colorLine7;
    } else if (subwayLine.contains("8호선")){
      return getColorScheme(context).colorLine8;
    } else if (subwayLine.contains("9호선")){
      return getColorScheme(context).colorLine9;
    } else if (subwayLine.contains("중앙선")){
      return getColorScheme(context).colorLineGyeonguiCentral;
    } else if (subwayLine.contains("경의중앙선")){
      return getColorScheme(context).colorLineGyeonguiCentral;
    } else if (subwayLine.contains("공항철도")){
      return getColorScheme(context).colorLineAirportRailroad;
    } else if (subwayLine.contains("경춘선")){
      return getColorScheme(context).colorLineGyeongchun;
    } else if (subwayLine.contains("수인분당선")){
      return getColorScheme(context).colorLineSuinBundang;
    } else if (subwayLine.contains("신분당선")){
      return getColorScheme(context).colorLineNewParty;
    } else if (subwayLine.contains("우이신설선")){
      return getColorScheme(context).colorLineNewUisun;
    }

    return const Color(0xFFB6B6B6);
  }


  static String parseSubwayHoSun(String subwayName){

    debugPrint("parseSubwayHoSun: $subwayName");

    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    if (isNumeric(subwayName[0])){
      return subwayName[0];
    }else{
      return subwayName;
    }
  }


}