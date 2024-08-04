import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';

abstract class ZipcodeState {
  const ZipcodeState();
}

class Empty extends ZipcodeState {}

class Loading extends ZipcodeState {}

class Loaded extends ZipcodeState {
  final AddressEntity address;

  const Loaded({required this.address});
}

class Error extends ZipcodeState {
  final String message;

  const Error({required this.message});
}
