import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/local/LocalApi.dart';
import 'package:subway_ody/data/data_source/remote/KakaoApi.dart';
import 'package:subway_ody/data/data_source/remote/SubwayApi.dart';
import 'package:subway_ody/data/repositories/local/LocalRepositoryImpl.dart';
import 'package:subway_ody/data/repositories/remote/KakaoGpsRepositoryImpl.dart';
import 'package:subway_ody/data/repositories/remote/SubwayRepositoryImpl.dart';
import 'package:subway_ody/domain/repositories/local/LocalRepository.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';
import 'package:subway_ody/domain/repositories/remote/SubwayRepository.dart';
import 'package:subway_ody/domain/usecases/local/GetAutoRefreshCallUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLatLngUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetUserDistanceUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PostAutoRefreshCallUseCase.dart';
import 'package:subway_ody/domain/usecases/local/PostSaveUserDistanceUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetKakaoLatLngToRegionUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetNearBySubwayStationUseCase.dart';
import 'package:subway_ody/domain/usecases/remote/GetSubwayArrivalUseCase.dart';
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
  GetIt.instance.registerLazySingleton<GetUserDistanceUseCase>(() => GetUserDistanceUseCase());
  GetIt.instance.registerLazySingleton<PostSaveUserDistanceUseCase>(() => PostSaveUserDistanceUseCase());
  GetIt.instance.registerLazySingleton<GetSubwayArrivalUseCase>(() => GetSubwayArrivalUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalRepository>(() => LocalRepositoryImpl());
  GetIt.instance.registerLazySingleton<KakaoGpsRepository>(() => KakaoGpsRepositoryImpl());
  GetIt.instance.registerLazySingleton<SubwayRepository>(() => SubwayRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalApi>(() => LocalApi());
  GetIt.instance.registerLazySingleton<KakaoApi>(() => KakaoApi());
  GetIt.instance.registerLazySingleton<SubwayApi>(() => SubwayApi());
}
