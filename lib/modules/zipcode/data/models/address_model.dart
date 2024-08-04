import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel(
      {required super.cep,
      required super.rua,
      required super.complemento,
      required super.bairro,
      required super.cidade,
      required super.uf});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'],
      rua: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidade: json['localidade'],
      uf: json['uf'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'rua': rua,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
    };
  }
}
