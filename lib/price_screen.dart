import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'exchange_rate.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  double btcToFiat = 0;
  double ltcToFiat = 0;
  double ethToFiat = 0;

  void updateConversions() async {
    CryptoInfo cryptoInfo = CryptoInfo();
    setState(() async {
      btcToFiat = await cryptoInfo.getExchangeRate(
          cryptoCurrency: 'BTC', fiatCurrency: selectedCurrency);
      ltcToFiat = await cryptoInfo.getExchangeRate(
          cryptoCurrency: 'LTC', fiatCurrency: selectedCurrency);
      ethToFiat = await cryptoInfo.getExchangeRate(
          cryptoCurrency: 'ETH', fiatCurrency: selectedCurrency);
    });

    // ethToFiat = cryptoInfo.getExchangeRate(
    //     cryptoCurrency: 'ETH', fiatCurrency: selectedCurrency);
  }

  DropdownButton<String> getAndroidDropDown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getDropDownItems(),
      onChanged: (String? value) {
        setState(() {
          selectedCurrency = value;
          updateConversions();
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> item =
          DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItems.add(item);
    }
    return dropDownItems;
  }

  CupertinoPicker getIOSPicker() {
    return CupertinoPicker(
      children: getPickerItems(),
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      itemExtent: 32.0,
    );
  }

  List<Text> getPickerItems() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      Text item = Text(currency);
      items.add(item);
    }
    return items;
  }

  Widget? getPicker() {
    if (Platform.isAndroid) {
      return getAndroidDropDown();
    } else if (Platform.isIOS) {
      return getIOSPicker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcToFiat $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcToFiat $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethToFiat $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
