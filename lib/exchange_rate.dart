import 'network_helper.dart';
import 'dart:convert';

const coinAPIURL = 'https://rest.coinapi.io/v1';
const apiKey = '8766DA5F-7E4D-490B-B3D2-8FDA4DF080C7';

class CryptoInfo {
  getExchangeRate(
      {required String cryptoCurrency, String? fiatCurrency}) async {
    print('got here');
    NetworkHelper networkHelper = NetworkHelper(
        '$coinAPIURL/exchangerate/$cryptoCurrency/$fiatCurrency/?apikey=$apiKey');
    var currencyData = await networkHelper.getData();
    double rate = currencyData['rate'];

    print(rate);
    return rate;
  }
}
