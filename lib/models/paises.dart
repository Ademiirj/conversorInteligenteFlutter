class Country {
  final String name;
  final String currency;
  final String image;
  final double minimumPay;
  final int workDay;

  Country(this.name, this.currency, this.image, this.minimumPay, this.workDay);

  static List<Country> getCountry() {
    List<Country> teste = [
      Country('Brasil', 'real', 'imagens/bandeira-brasil.png', 5.22, 8),
      Country('Belgica', 'euro', 'imagens/bandeira-belgica.png', 9.08, 8),
      Country(
          'Chile', 'peso chileno', 'imagens/bandeira-Chile.png', 1232.58, 9),
      Country('Franca', 'euro', 'imagens/bandeira-franca.png', 9.67, 7),
      Country('Holanda', 'euro', 'imagens/bandeira-holanda.png', 8.04, 8),
      Country('Irlanda', 'euro', 'imagens/bandeira-irlanda.png', 9.55, 8),
      Country('Portgual', 'euro', 'imagens/bandeira-portugal.png', 3.45, 8),
      Country('Reino Unido', 'euro', 'imagens/bandeira-reino.png', 6.70, 8),
      Country('EUA', 'dolar', 'imagens/bandeira-eua.png', 7.25, 8),
    ];
    return teste;
  }

  @override
  String toString() {
    return 'Pais{nome: $name: $currency';
  }
}
