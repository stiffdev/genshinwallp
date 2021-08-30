import 'package:flutter/material.dart';
import 'package:genshinwallp/src/ads/helper_ad.dart';
import 'package:genshinwallp/src/sharedprefs/shared_prefs.dart';
import 'package:genshinwallp/src/widgets/back_button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// ignore: must_be_immutable
class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  Items item5 = new Items(
    id: '/live',
    title: "Live Wallpapers",
    img: "lib/src/assets/skliv.png",
  );

  Items item2 = new Items(
    id: '/wallsel',
    title: "Custom Wallpapers",
    img: "lib/src/assets/character/sk2.png",
  );

  Items item1 = new Items(
      id: '/selchar',
      title: "Characters Creator",
      img: "lib/src/assets/character/sk1.png");

  Items item3 = new Items(
    id: '/map',
    title: "Map",
    img: "lib/src/assets/map.png",
  );

  Items item4 = new Items(
    id: '/codes',
    title: "Last Codes",
    img: "lib/src/assets/mora.png",
  );

  Items item6 = new Items(
    id: '/tips',
    title: "Tips",
    img: "lib/src/assets/gem.png",
  );

  final prefs = new PreferenciasUsuario();

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  String navItem = 'live';

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item5, item2, item1, item3, item4, item6];
    var color = 0xff453658;

    return Material(
      child: Container(
          decoration: _widgetBackground(),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: EdgeInsets.all(20), child: MainBackButton()),
              // SizedBox(height: 50),
              Flexible(
                child: GridView.count(
                    childAspectRatio: 1.0,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    children: myList.map((data) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              navItem = data.id;
                              if (_isInterstitialAdReady && _checkPol2()) {
                                _interstitialAd?.show();
                              } else {
                                Navigator.pushNamed(context, '$navItem');
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  data.img,
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Card(data: data),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              ),
            ],
          ))),
    );
  }

  void _loadInterstitialAd() {
    print('cargo interstitial 2');
    InterstitialAd.load(
      adUnitId: AdsHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //navigate to next page or do something
              //_loadInterstitialAd();
              _isInterstitialAdReady = false;
              _loadInterstitialAd();
              Navigator.pushNamed(context, navItem);
            },
          );

          _isInterstitialAdReady = true;
          print('interstitial 2 is loaded');
        },
        onAdFailedToLoad: (err) {
          print('Failed to load interstitial ad 2: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  /* Future<bool> myTypedFuture() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('Error from Exception');
  }*/

  /*_checkSeeMenu() {
    var men = prefs.seemenu;
    prefs.seemenu = men + 1;

    if(prefs.seemenu >2){

    }
  }*/

  bool _checkPol2() {
    if (prefs.pol2 == 1) {
      return false;
    } else {
      return true;
    }
  }
}

class Card extends StatelessWidget {
  final Items data;

  Card({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

BoxDecoration _widgetBackground() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage("lib/src/assets/bg.png"),
      fit: BoxFit.cover,
    ),
  );
}

class Items {
  String id;
  String title;
  String img;
  Items({required this.id, required this.title, required this.img});
}
