import 'package:dartz/dartz.dart';
import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';

import '../../../../core/error/failure.dart';

abstract class ZipcodeRepository {
  Future<Either<Failure, AddressEntity>> getAddressByZipcode(String cep);
}
