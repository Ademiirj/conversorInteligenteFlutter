import 'package:conversor/models/paises.dart';
import 'package:conversor/screens/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

const _tituloAppBar = "Calculadora porder de compra";

class ExibePais extends StatefulWidget {
  @override
  _ExibePaisState createState() => _ExibePaisState();
}

class _ExibePaisState extends State<ExibePais> {
  static double price;
  var _priceController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: '\$ ');
  String _resultText = '';
  String _selectedImage = 'imagens/bandeira-brasil.png';
  List<Country> _countries = Country.getCountry();
  List<DropdownMenuItem<Country>> _dropdownMenuItems;
  Country _selectedCountry;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_countries);
    _selectedCountry = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Country>> buildDropdownMenuItems(List countries) {
    List<DropdownMenuItem<Country>> items = List();
    for (Country country in countries) {
      items.add(
        DropdownMenuItem(
          value: country,
          child: Text(country.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Country selectedCountry) {
    setState(() {
      _selectedCountry = selectedCountry;
      _selectedImage = selectedCountry.image;
      if (price != null) {
        String result = calculateResult(_selectedCountry, price);
        _resultText = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      drawer: ExibeMenu(),
      body: new Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(_selectedImage),
                DropdownButton(
                  value: _selectedCountry,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                  child: TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite um valor',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28.0, 8.0, 28.0, 16.0),
                  child: Text(_resultText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    try {
                      _ExibePaisState.price = _priceController.numberValue;
                      setState(() {
                        String result =
                            calculateResult(_selectedCountry, price);
                        _resultText = result;
                      });
                    } catch (e) {
                      debugPrint(e);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(120.0, 8.0, 120.0, 8.0),
                    child: Text(
                      "Converter",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String calculateResult(Country pais, double valor) {
  bool ademir = getSwitchMenu();

  double _minimumPay = pais.minimumPay;
  int _workDay = pais.workDay;

  if (ademir) {
    if (getMenuPayment() != 0.00) {
      _minimumPay = getMenuPayment();
    }
    if (getMenuWordDay() > 0) {
      _workDay = getMenuWordDay();
    }
  }

  double result = (valor * 60) / _minimumPay; //convertendo dinhiero pra minuto
  var time = result * 60; //convertendo minuto para segundos

  int hour = time ~/ 3600;
  int minute = (time - (3600 * hour)) ~/ 60;

  int day = (hour ~/ _workDay);
  hour -= (day * _workDay);

  return "Você ira demorar $day dias $hour horas e $minute minutos trabalhados para conquistar este valor";
}