// coverage:ignore-file
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../data/repository/version_check/remote_version_check_repo.dart';
import '../../domain/repository/version_repo.dart';
import '../../presentation/_common_widgets/hud_overlay.dart';
import '../_core.dart';
import '../exceptions/_exceptions.dart';

final getIt = GetIt.instance;

/// Registering dependency injections for core modules.
Future<void> initCoreAppModule() async {
  // Randomization
  getIt.registerLazySingleton<Random>(() => Random());

  // Error Handlers
  getIt.registerLazySingleton<ErrorLogger>(() => ErrorLogger());
  getIt.registerLazySingleton<NetworkErrorHandlerService>(() => const NetworkErrorHandlerService());

  // ApiService
  final dio = DioFactory().getDio();
  getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio, getIt<InternetConnection>()));

  // Theme
  getIt.registerSingletonAsync<PlatformBrightnessBloc>(() async {
    final brightness = PlatformBrightnessBloc();
    await brightness.init();
    return brightness;
  });

  // HUD feature
  getIt.registerLazySingleton<HudControllerCubit>(() => HudControllerCubit());

  // VersionCheck feature
  // * Using lazySingleton since it maintains no state, and should exist only when it's called.
  getIt.registerLazySingleton<VersionCheckRepo>(() => RemoteVersionCheckRepo(getIt<ApiService>()));

  // Generate id content feature
  getIt.registerLazySingleton(() => Faker());
}
