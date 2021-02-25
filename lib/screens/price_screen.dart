import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_foytingo/models/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  static String id = 'price_screen';

  PriceScreen({this.coinDatas});
  final coinDatas;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String BTCrate;
  String LTCrate;
  String ETHrate;

  @override
  void initState() {
    super.initState();
    updateUI(widget.coinDatas);
  }

  void updateUI(dynamic coinDatas) {
    setState(() {
      if (coinDatas == null) {
        BTCrate = 'Err';
        LTCrate = 'Err';
        ETHrate = 'Err';
        return;
      }
      var btcData = coinDatas['BTC'];
      var ltcData = coinDatas['LTC'];
      var ethData = coinDatas['ETH'];

      BTCrate = btcData['rate'].toStringAsFixed(2);
      LTCrate = ltcData['rate'].toStringAsFixed(2);
      ETHrate = ethData['rate'].toStringAsFixed(2);
    });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        scrollController: FixedExtentScrollController(
            initialItem: currenciesList.indexOf('USD')),
        onSelectedItemChanged: (selectedIndex) async {
          selectedCurrency = currenciesList[selectedIndex];
          var coinDatas = await CoinData().getAllCoinData(selectedCurrency);
          updateUI(coinDatas);
        },
        children: pickerItems);
  }

  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) async {
          selectedCurrency = value;
          var coinDatas = await CoinData().getAllCoinData(selectedCurrency);
          updateUI(coinDatas);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '1 BTC = $BTCrate $selectedCurrency',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '1 LTC = $LTCrate $selectedCurrency',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '1 ETH = $ETHrate $selectedCurrency',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
            alignment: Alignment.center,
            color: Colors.orange,
            height: 150.0,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          )
        ],
      ),
    );
  }
}
