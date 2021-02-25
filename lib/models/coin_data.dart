import 'package:bitcoin_ticker_foytingo/network_service.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// API key example:
// const apikey = 'B84456467A0-0CD7-41BA-ACC5-6CB8BC5464567456456';
const apikey = 'api-key-is-here';
const coinIOURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getAllCoinData(String currency) async {
    var coinDatas = new Map();

    for (String coin in cryptoList) {
      var url = '$coinIOURL/$coin/$currency?apikey=$apikey';
      NetworkService networkService = NetworkService(url: url);
      var coinData = await networkService.getData();
      coinDatas[coin] = coinData;
    }
    return coinDatas;
  }
}
