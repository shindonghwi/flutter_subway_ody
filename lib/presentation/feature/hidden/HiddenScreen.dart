import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/usecases/local/GetDemoUserLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PostDemoUserLatLngUseCase.dart';
import 'package:subway_ody/presentation/feature/hidden/HiddenAppBar.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SnackBarUtil.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/dto/Pair.dart';

class HiddenScreen extends HookWidget {
  HiddenScreen({Key? key}) : super(key: key);

  final items = [
    Pair("1호선 - 인천", LatLng(126.6170, 37.4764)),
    Pair("1호선 - 구일", LatLng(126.8699, 37.4964)),
    Pair("1호선 - 구로", LatLng(126.8822, 37.5035)),
    Pair("1호선 - 신도림", LatLng(126.8912, 37.5089)),
    Pair("1호선 - 가산디지털단지", LatLng(126.8832, 37.4805)),
    Pair("1호선 - 금천구청", LatLng(126.8937, 37.4562)),
    Pair("1호선 - 광명", LatLng(126.8851, 37.4171)),
    Pair("1호선 - 병점", LatLng(126.0332, 37.2069)),
    Pair("1호선 - 세류", LatLng(126.0136, 37.2442)),
    Pair("1호선 - 서동탄", LatLng(126.0517, 37.1958)),
    Pair("1호선 - 신창", LatLng(126.9517, 36.7699)),
    Pair("1호선 - 평택", LatLng(127.0852, 36.9911)),
    Pair("1호선 - 소요산", LatLng(127.0610, 37.9475)),
    Pair("1호선 - 동두천", LatLng(127.0550, 37.9275)),
    Pair("2호선 - 까치산", LatLng(126.8472, 37.5311)),
    Pair("2호선 - 신도림", LatLng(126.8913, 37.5087)),
    Pair("2호선 - 문래", LatLng(126.8945, 37.5183)),
    Pair("2호선 - 대림", LatLng(126.8954, 37.4921)),
    Pair("2호선 - 시청", LatLng(126.9772, 37.5646)),
    Pair("2호선 - 충정로", LatLng(126.9636, 37.5593)),
    Pair("2호선 - 신설동", LatLng(127.0234, 37.5757)),
    Pair("2호선 - 성수", LatLng(127.0561, 37.5447)),
    Pair("2호선 - 건대입구", LatLng(127.0707, 37.5400)),
    Pair("3호선 - 오금", LatLng(127.1282, 37.5018)),
    Pair("3호선 - 수서", LatLng(127.1018, 37.4875)),
    Pair("3호선 - 대화", LatLng(126.7475, 37.6762)),
    Pair("3호선 - 주엽", LatLng(126.7615, 37.6702)),
    Pair("4호선 - 당고개", LatLng(127.0791, 37.6703)),
    Pair("4호선 - 혜화", LatLng(127.0019, 37.5821)),
    Pair("4호선 - 오이도", LatLng(126.7387, 37.3617)),
    Pair("4호선 - 신길온천", LatLng(126.7672, 37.3376)),
    Pair("5호선 - 방화", LatLng(126.8127, 37.5775)),
    Pair("5호선 - 여의도", LatLng(126.9243, 37.5217)),
    Pair("5호선 - 천호", LatLng(127.1236, 37.5386)),
    Pair("5호선 - 강동", LatLng(127.1323, 37.5359)),
    Pair("5호선 - 길동", LatLng(127.1399, 37.5380)),
    Pair("5호선 - 둔촌동", LatLng(127.1362, 37.5277)),
    Pair("5호선 - 하남검단산", LatLng(127.2233, 37.5398)),
    Pair("5호선 - 마천", LatLng(127.1527, 37.4948)),
    Pair("6호선 - 신내", LatLng(127.1033, 37.6128)),
    Pair("6호선 - 화랑대", LatLng(127.0836, 37.6200)),
    Pair("6호선 - 새절", LatLng(126.9135, 37.5909)),
    Pair("6호선 - 응암", LatLng(126.9156, 37.5985)),
    Pair("6호선 - 구산", LatLng(126.9171, 37.6112)),
    Pair("6호선 - 불광", LatLng(126.9295, 37.6111)),
    Pair("7호선 - 장암", LatLng(127.0524, 37.6998)),
    Pair("7호선 - 군자", LatLng(127.0794, 37.5573)),
    Pair("7호선 - 상동", LatLng(126.7532, 37.5058)),
    Pair("7호선 - 석남", LatLng(126.6762, 37.5063)),
    Pair("8호선 - 암사역", LatLng(127.1273, 37.5491)),
    Pair("8호선 - 천호", LatLng(127.1237, 37.5385)),
    Pair("8호선 - 모란", LatLng(127.1292, 37.4338)),
    Pair("8호선 - 단대오거리", LatLng(127.1566, 37.4450)),
    Pair("9호선 - 중앙보훈병원", LatLng(127.1484, 37.5285)),
    Pair("9호선 - 봉은사", LatLng(127.0601, 37.5142)),
    Pair("9호선 - 개화", LatLng(126.7951, 37.5778)),
    Pair("9호선 - 김포공항", LatLng(126.8106, 37.5636)),
    Pair("수인분당선 - 청량리", LatLng(127.0475, 37.5804)),
    Pair("수인분당선 - 인천", LatLng(126.6174, 37.4763)),
    Pair("수인분당선 - 매교", LatLng(127.0159, 37.2654)),
    Pair("우이신설선 - 신설동", LatLng(127.0232, 37.5757)),
    Pair("우이신설선 - 화계", LatLng(127.0173, 37.6340)),
    Pair("우이신설선 - 북한산우이", LatLng(127.0125, 37.6630)),
    Pair("경춘선 - 청량리", LatLng(127.0451, 37.5802)),
    Pair("경춘선 - 광운대", LatLng(127.0617, 37.6238)),
    Pair("경춘선 - 상봉", LatLng(127.0850, 37.5968)),
    Pair("경춘선 - 신내", LatLng(127.1032, 37.6127)),
    Pair("경춘선 - 춘천", LatLng(127.7168, 37.8847)),
    Pair("경춘선 - 남춘천", LatLng(127.7240, 37.8637)),
    Pair("경의중앙선 - 지평", LatLng(127.6294, 37.4766)),
    Pair("경의중앙선 - 신촌", LatLng(126.9424, 37.5597)),
    Pair("경의중앙선 - 가좌", LatLng(126.9143, 37.5689)),
    Pair("경의중앙선 - 디지털미디어시티", LatLng(126.8997, 37.5779)),
    Pair("경의중앙선 - 백마", LatLng(126.7946, 37.6579)),
    Pair("경의중앙선 - 용문", LatLng(127.5940, 37.4822)),
    Pair("경의중앙선 - 지평", LatLng(127.6294, 37.4766)),
    Pair("경의중앙선 - 신촌", LatLng(126.9424, 37.5597)),
    Pair("경의중앙선 - 가좌", LatLng(126.9143, 37.5689)),
    Pair("경의중앙선 - 디지털미디어시티", LatLng(126.8997, 37.5779)),
    Pair("경의중앙선 - 백마", LatLng(126.7946, 37.6579)),
    Pair("경의중앙선 - 용문", LatLng(127.5940, 37.4822)),
    Pair("공항철도 - 서울역", LatLng(126.9727, 37.5528)),
    Pair("공항철도 - 인천공항2터미널", LatLng(126.4321, 37.4677)),
    Pair("신분당선 - 광교", LatLng(127.0441, 37.3018)),
    Pair("신분당선 - 신사", LatLng(127.0198, 37.5161)),
  ];

  @override
  Widget build(BuildContext context) {
    ValueNotifier<LatLng?> isSelectedLatLng = useState(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final savedLatLng = await GetIt.instance<GetDemoUserLatLngUseCase>().call();
        isSelectedLatLng.value = LatLng(savedLatLng?.latitude, savedLatLng?.longitude);
      });
    }, []);

    return Scaffold(
      appBar: const HiddenAppBar(),
      backgroundColor: getColorScheme(context).light,
      body: SafeArea(
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            final mainColor = SubwayUtil.getMainColor(item.first.split(" ").first);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: getColorScheme(context).black,
                  width: 1,
                ),
                color: mainColor.withOpacity(
                    item.second.latitude == isSelectedLatLng.value?.longitude &&
                            item.second.longitude == isSelectedLatLng.value?.latitude
                        ? 0.3
                        : 0.0),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    GetIt.instance<PostDemoUserLatLngUseCase>().call(item.second);
                    SnackBarUtil.show(context, "${item.first} 지하철역으로 설정되었습니다.");
                    Navigator.of(context).pop(item.second);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: mainColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item.first,
                          style: getTextTheme(context).medium.copyWith(
                                color: getColorScheme(context).black,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8);
          },
          itemCount: items.length,
        ),
      ),
    );
  }
}
