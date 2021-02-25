import 'package:bitcoin_ticker_foytingo/screens/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bitcoin_ticker_foytingo/models/coin_data.dart';

class LoadingScreen extends StatefulWidget {
  static String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getAllCoinData() async {
    String initialCurrency = 'USD';
    var coinDatas = await CoinData().getAllCoinData(initialCurrency);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(coinDatas: coinDatas);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.orange,
          size: 100.0,
        ),
      ),
    );
  }
}
