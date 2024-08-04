import 'package:dartz/dartz.dart';
import 'package:search_zipcode/core/error/failure.dart';
import 'package:search_zipcode/core/network/network_info.dart';
import 'package:search_zipcode/modules/zipcode/data/datasources/zipcode_remote_datasource.dart';
import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';
import 'package:search_zipcode/modules/zipcode/domain/repositories/zipcode_repository.dart';

class ZipcodeRepositoryImpl implements ZipcodeRepository {
  final ZipcodeRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ZipcodeRepositoryImpl(
      {required this.networkInfo, required this.remoteDatasource});
  @override
  Future<Either<Failure, AddressEntity>> getAddressByZipcode(String cep) async {
    if (await networkInfo.isConnected) {
      try {
        final address = await remoteDatasource.getZipcodeByAddress(cep);
        return Right(address);
      } on ZipcodeFailure {
        return Left(ZipcodeFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
