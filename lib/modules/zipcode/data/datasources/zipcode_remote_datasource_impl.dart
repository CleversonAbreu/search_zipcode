import 'package:dio/dio.dart';
import 'package:search_zipcode/core/error/failure.dart';
import 'package:search_zipcode/modules/zipcode/data/datasources/zipcode_remote_datasource.dart';
import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';

import '../models/address_model.dart';

class ZipcodeRemoteDatasourceImpl implements ZipcodeRemoteDatasource {
  final Dio dio;

  ZipcodeRemoteDatasourceImpl({required this.dio});
  @override
  Future<AddressEntity> getZipcodeByAddress(String cep) async {
    try {
      final response = await dio.get('https://viacep.com.br/ws/$cep/json/',
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode == 200) {
        if (response.data['erro'] != null && response.data['erro'] == 'true') {
          throw ZipcodeFailure();
        }
        return AddressModel.fromJson(response.data);
      } else {
        throw ServerFailure();
      }
    } on ZipcodeFailure {
      throw ZipcodeFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }
}
