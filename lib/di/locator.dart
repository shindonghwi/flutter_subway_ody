import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/local/LocalGpsApi.dart';
import 'package:subway_ody/data/data_source/remote/KakaoApi.dart';
import 'package:subway_ody/data/repositories/local/LocalAppRepositoryImpl.dart';
import 'package:subway_ody/data/repositories/remote/KakaoGpsRepositoryImpl.dart';
import 'package:subway_ody/domain/repositories/local/LocalGpsRepository.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';
import 'package:subway_ody/domain/usecases/local/GetAutoRefreshCallUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PostAutoRefreshCallUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetKakaoLatLngToRegionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetNearBySubwayStationUseCase.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {

  GetIt.instance.registerLazySingleton<AppLocalization>(() => AppLocalization());


  /// -------
  /// usecase
  /// -------
  GetIt.instance.registerLazySingleton<GetLocationPermissionUseCase>(() => GetLocationPermissionUseCase());
  GetIt.instance.registerLazySingleton<PostAutoRefreshCallUseCase>(() => PostAutoRefreshCallUseCase());
  GetIt.instance.registerLazySingleton<GetAutoRefreshCallUseCase>(() => GetAutoRefreshCallUseCase());
  GetIt.instance.registerLazySingleton<GetLatLngCallUseCase>(() => GetLatLngCallUseCase());
  GetIt.instance.registerLazySingleton<GetKakaoLatLngToRegionUseCase>(() => GetKakaoLatLngToRegionUseCase());
  GetIt.instance.registerLazySingleton<GetNearBySubwayStationUseCase>(() => GetNearBySubwayStationUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalGpsRepository>(() => LocalGpsRepositoryImpl());
  GetIt.instance.registerLazySingleton<KakaoGpsRepository>(() => KakaoGpsRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalGpsApi>(() => LocalGpsApi());
  GetIt.instance.registerLazySingleton<KakaoApi>(() => KakaoApi());
}
