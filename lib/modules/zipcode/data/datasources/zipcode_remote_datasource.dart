import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';

abstract class ZipcodeRemoteDatasource {
  Future<AddressEntity> getZipcodeByAddress(String cep);
}
