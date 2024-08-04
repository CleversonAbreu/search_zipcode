// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:search_zipcode/core/error/failure.dart';
import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';
import 'package:search_zipcode/modules/zipcode/domain/repositories/zipcode_repository.dart';
import 'package:search_zipcode/modules/zipcode/domain/usescases/get_address_by_zipcode_usecase.dart';

class GetAddressByZipcodeUsecaseImpl implements GetAddressByZipcodeUsecase {
  ZipcodeRepository repository;
  GetAddressByZipcodeUsecaseImpl({
    required this.repository,
  });
  @override
  Future<Either<Failure, AddressEntity>> call(String cep) async {
    return await repository.getAddressByZipcode(cep);
  }
}
