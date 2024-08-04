import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_zipcode/core/error/failure.dart';
import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';
import 'package:search_zipcode/modules/zipcode/domain/repositories/zipcode_repository.dart';
import 'package:search_zipcode/modules/zipcode/domain/usescases/get_address_by_zipcode_usecase_impl.dart';

class MockZipcodeRepository extends Mock implements ZipcodeRepository {}

void main() {
  late GetAddressByZipcodeUsecaseImpl usecase;
  late MockZipcodeRepository mockZipcodeRepository;

  setUp(() {
    mockZipcodeRepository = MockZipcodeRepository();
    usecase = GetAddressByZipcodeUsecaseImpl(repository: mockZipcodeRepository);
  });

  const tCep = '12345678';
  final tAddressEntity = AddressEntity(
    rua: 'Rua Exemplo',
    cidade: 'Cidade Exemplo',
    uf: 'Estado Exemplo',
    bairro: 'Bairro Exemplo',
    cep: '12345678',
    complemento: 'complemento',
  );

  test(
    'should get address for the given cep from the repository',
    () async {
      // arrange
      when(mockZipcodeRepository.getAddressByZipcode(anyString))
          .thenAnswer((_) async => Right(tAddressEntity));

      // act
      final result = await usecase(tCep);

      // assert
      expect(result, Right(tAddressEntity));
      verify(mockZipcodeRepository.getAddressByZipcode(tCep));
      verifyNoMoreInteractions(mockZipcodeRepository);
    },
  );

  test(
    'should return a failure when the repository fails',
    () async {
      // arrange
      when(mockZipcodeRepository.getAddressByZipcode(anyString))
          .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(tCep);

      // assert
      expect(result, Left(ServerFailure()));
      verify(mockZipcodeRepository.getAddressByZipcode(tCep));
      verifyNoMoreInteractions(mockZipcodeRepository);
    },
  );
}

// Helper function to specify type as String
// ignore: cast_from_null_always_fails
String get anyString => any as String;
