import 'package:dartz/dartz.dart';
import 'package:search_zipcode/modules/zipcode/data/repositories/zipcode_repository_impl.dart';
import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';

import '../../../../core/error/failure.dart';

abstract class GetAddressByZipcodeUsecase {
  GetAddressByZipcodeUsecase(ZipcodeRepositoryImpl zipcodeRepository);

  Future<Either<Failure, AddressEntity>> call(String cep);
}
