import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity/connectivity.dart';
import 'package:search_zipcode/core/network/network_info_impl.dart';
import 'package:search_zipcode/modules/zipcode/data/datasources/zipcode_remote_datasource_impl.dart';
import 'package:search_zipcode/modules/zipcode/data/repositories/zipcode_repository_impl.dart';
import 'package:search_zipcode/modules/zipcode/domain/usescases/get_address_by_zipcode_usecase_impl.dart';
import 'package:search_zipcode/modules/zipcode/presentation/cubit/zipcode_cubit.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Registre Dio
  locator.registerLazySingleton<Dio>(() => Dio());

  // Registre Connectivity
  locator.registerLazySingleton<Connectivity>(() => Connectivity());

  // Registre NetworkInfo
  locator.registerLazySingleton<NetworkInfoImpl>(() => NetworkInfoImpl(connectivity: locator<Connectivity>()));

  // Registre ZipcodeRemoteDatasourceImpl
  locator.registerLazySingleton<ZipcodeRemoteDatasourceImpl>(() => ZipcodeRemoteDatasourceImpl(dio: locator<Dio>()));

  // Registre ZipcodeRepositoryImpl
  locator.registerLazySingleton<ZipcodeRepositoryImpl>(() => ZipcodeRepositoryImpl(
        remoteDatasource: locator<ZipcodeRemoteDatasourceImpl>(),
        networkInfo: locator<NetworkInfoImpl>(),
      ));

  // Registre GetAddressByZipcodeUsecaseImpl
  locator.registerLazySingleton<GetAddressByZipcodeUsecaseImpl>(() => GetAddressByZipcodeUsecaseImpl(repository: locator<ZipcodeRepositoryImpl>()));

  // Registre ZipcodeCubit
  locator.registerFactory(() => ZipcodeCubit(getAddressByZipcodeUsecase: locator<GetAddressByZipcodeUsecaseImpl>()));
}
