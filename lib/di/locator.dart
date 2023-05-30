import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/local/gps/LocalGpsApi.dart';
import 'package:subway_ody/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:subway_ody/domain/repositories/local/gps/LocalGpsRepository.dart';
import 'package:subway_ody/domain/usecases/local/app/GetLocationPermissionUseCase.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  /// -------
  /// common
  /// -------
  // GetIt.instance.registerLazySingleton<AppLocalization>(() => AppLocalization());


  /// -------
  /// usecase
  /// -------

  // //app
  GetIt.instance.registerLazySingleton<GetLocationPermissionUseCase>(() => GetLocationPermissionUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalGpsRepository>(() => LocalGpsRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalGpsApi>(() => LocalGpsApi());
}
