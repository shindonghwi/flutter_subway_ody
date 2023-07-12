import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/app/SubwayOdyApp.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/presentation/feature/naver_map/model/MapAppBarModel.dart';
import 'package:subway_ody/presentation/feature/provider/MainUiState.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SubwayUtil.dart';
import 'package:subway_ody/presentation/utils/SystemUtil.dart';

class NaverMapScreen extends HookConsumerWidget {
  final MapAppBarModel? model;

  const NaverMapScreen({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiStateRead = ref.read(mainUiStateProvider.notifier);

    final hosun = model?.hosun ?? "";
    final subwayName = model?.subwayName ?? "";
    final distance = model?.distance ?? "0";
    final mainColor = model?.mainColor ?? Colors.transparent;
    final double userLatitude = uiStateRead.latLng?.latitude ?? 0;
    final double userLongitude = uiStateRead.latLng?.longitude ?? 0;
    final LatLng? stationLatLng = model?.latLng;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColorScheme(context).light,
        bottomOpacity: 0.0,
        elevation: 1.0,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: hosun.length == 1 ? 30 : 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(hosun.length == 1 ? 100 : 14),
                border: Border.all(
                  color: mainColor,
                  width: 1,
                ),
                color: mainColor,
              ),
              child: Center(
                child: Text(
                  hosun,
                  style: getTextTheme(context).bold.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.28,
                      ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              SubwayUtil.findLanguageSubwayName(
                subwayName,
                languageType: SystemUtil.getLanguageType(SubwayOdyApp.currentLocale),
              ),
              style: getTextTheme(context).bold.copyWith(
                    color: const Color(0xFF2F2F2F),
                    fontSize: 18,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "${distance}m",
              style: getTextTheme(context).medium.copyWith(
                    color: const Color(0xFF7C7C7C),
                    fontSize: 16,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: getColorScheme(context).colorPrimary,
                ),
                margin: const EdgeInsets.only(right: 20),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          getAppLocalizations(context).common_close,
                          style: getTextTheme(context).medium.copyWith(
                                color: getColorScheme(context).white,
                                fontSize: 14,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: NaverMap(
                options: NaverMapViewOptions(
                  mapType: NMapType.basic, // 일반 지도
                  activeLayerGroups: [
                    NLayerGroup.building, // 빌딩 그룹. 활성화되면 건물을 표시
                    NLayerGroup.transit, // 대중 교통 요소를 표시
                  ],
                  locationButtonEnable: true,
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(userLatitude, userLongitude),
                    zoom: 13,
                    bearing: 0,
                    tilt: 0,
                  ),
                ),
                onMapReady: (controller) async {
                  controller.setLocationTrackingMode(NLocationTrackingMode.follow);
                  final loadImageUint8 = (await rootBundle.load("assets/imgs/icon_arrival.png")).buffer.asUint8List();
                  final iconWidget = await NOverlayImage.fromByteArray(loadImageUint8);
                  final marker = NMarker(
                    id: "destination",
                    position: NLatLng(stationLatLng?.longitude ?? 0, stationLatLng?.latitude ?? 0),
                    icon: iconWidget,
                    size: const NSize(40, 40),
                  );

                  controller.addOverlay(marker);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
