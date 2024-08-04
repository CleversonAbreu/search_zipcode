class AddressEntity {
  final String cep;
  final String rua;
  final String complemento;
  final String bairro;
  final String cidade;
  final String uf;

  AddressEntity({
    required this.cep,
    required this.rua,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.uf,
  });
}
