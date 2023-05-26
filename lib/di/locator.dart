import 'package:get_it/get_it.dart';

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
  // GetIt.instance.registerLazySingleton<GetAppPolicyCheckUseCase>(() => GetAppPolicyCheckUseCase());
  // GetIt.instance.registerLazySingleton<GetAppPolicyUpdateUseCase>(() => GetAppPolicyUpdateUseCase());
  // GetIt.instance.registerLazySingleton<PostGoogleSignInUseCase>(() => PostGoogleSignInUseCase());
  // GetIt.instance.registerLazySingleton<PostSocialLoginInUseCase>(() => PostSocialLoginInUseCase());
  // GetIt.instance.registerLazySingleton<GetMeInfoUseCase>(() => GetMeInfoUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeGenderUseCase>(() => PatchMeGenderUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeBirthdayUseCase>(() => PatchMeBirthdayUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeHeightUseCase>(() => PatchMeHeightUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeWeightUseCase>(() => PatchMeWeightUseCase());
  // GetIt.instance.registerLazySingleton<PatchMeDiseasesUseCase>(() => PatchMeDiseasesUseCase());

  /// -------
  /// repository
  /// -------
  // GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  // GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());
  // GetIt.instance.registerLazySingleton<RemoteMeRepository>(() => RemoteMeRepositoryImpl());

  /// -------
  /// api
  /// -------
  // GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  // GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
  // GetIt.instance.registerLazySingleton<RemoteMeApi>(() => RemoteMeApi());
}
