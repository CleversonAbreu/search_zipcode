import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:search_zipcode/core/network/network_info_impl.dart';
import 'package:search_zipcode/modules/zipcode/domain/usescases/get_address_by_zipcode_usecase_impl.dart';

import 'modules/zipcode/data/datasources/zipcode_remote_datasource_impl.dart';
import 'modules/zipcode/data/repositories/zipcode_repository_impl.dart';

import 'modules/zipcode/domain/usescases/get_address_by_zipcode_usecase.dart';
import 'modules/zipcode/presentation/cubit/zipcode_cubit.dart';
import 'modules/zipcode/presentation/pages/zipcode_page.dart';

void main() {
  final dio = Dio();
  final zipcodeRemoteDataSource = ZipcodeRemoteDatasourceImpl(dio: dio);
  final connectivity = Connectivity();
  final networkInfo = NetworkInfoImpl(connectivity: connectivity);
  final zipcodeRepository = ZipcodeRepositoryImpl(
    remoteDatasource: zipcodeRemoteDataSource,
    networkInfo: networkInfo,
  );
  final getZipcodeInfo =
      GetAddressByZipcodeUsecaseImpl(repository: zipcodeRepository);

  runApp(MyApp(getZipcodeInfo: getZipcodeInfo));
}

class MyApp extends StatelessWidget {
  final GetAddressByZipcodeUsecase getZipcodeInfo;

  const MyApp({super.key, required this.getZipcodeInfo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca CEP',
      home: BlocProvider(
        create: (_) => ZipcodeCubit(getAddressByZipcodeUsecase: getZipcodeInfo),
        child: ZipcodePage(),
      ),
    );
  }
}
