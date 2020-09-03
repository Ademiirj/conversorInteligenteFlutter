import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:firebase_admob/firebase_admob.dart';

class ExibeMenu extends StatefulWidget {
  @override
  _ExibeMenuState createState() => _ExibeMenuState();
}

class _ExibeMenuState extends State<ExibeMenu> {
  static double payment;
  static int workDay;
  static bool personalCalculate = false;
  
  static const String testDevice = 'MobileID';
  BannerAd _bannerAd;
  
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['KEYWORDS']
  );

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print('BannerAd $event');
        }
    );
  }
  
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _bannerAd = createBannerAd()..load()..show(anchorType: AnchorType.bottom);
    super.initState();
  }
  
  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  onSwitchValueChanged(bool newVal) {
    setState(() {
      personalCalculate = newVal;
    });
  }

  var _controllerWordDay = new MaskedTextController(mask: '00');
  var _controllerPersonalPayment =
      MoneyMaskedTextController(decimalSeparator: '.', leftSymbol: '\$ ');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // DrawerHeader(
          //   child: Text('Header'),
          //   decoration: BoxDecoration(color: Colors.green[900]),
          // ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Switch(
                      value: personalCalculate,
                      onChanged: (newVal) {
                        onSwitchValueChanged(newVal);
                      }),
                  Text('Habilitar calculo Personalizado'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controllerPersonalPayment,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Salario Base',
                    hintText: 'Digite o salário mensal',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controllerWordDay,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Jornada diária',
                    hintText: 'Digite a jornada diária',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  setMenuValues(_controllerPersonalPayment.numberValue,
                      int.parse(_controllerWordDay.text));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sincronizar",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ), 
        ],
      ),
    );
  }
}

getSwitchMenu() {
  return _ExibeMenuState.personalCalculate;
}

getMenuPayment() {
  return _ExibeMenuState.payment;
}

getMenuWordDay() {
  return _ExibeMenuState.workDay;
}

setMenuValues(double payment, int workDay) {
  _ExibeMenuState.payment = payment;
  _ExibeMenuState.workDay = workDay;
}
