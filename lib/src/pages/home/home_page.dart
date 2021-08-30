import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genshinwallp/src/ads/helper_ad.dart';
import 'package:genshinwallp/src/providers/ObsProviders/home_provider.dart';
import 'package:genshinwallp/src/sharedprefs/shared_prefs.dart';
import 'package:genshinwallp/src/widgets/my_button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class BackgroundVideo extends StatefulWidget {
  @override
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  String _authStatus = 'Unknown';
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  late VideoPlayerController _controller;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    // if(prefs.status == '' || prefs.status == 'Unknown'){
    // WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());

    WidgetsBinding.instance?.addPostFrameCallback((_) => showTrackStatus());
    // }
    _loadInterstitialAd();
    _bannerAd = setBannerAd();
    _bannerAd?.load();
    getdtaPolicy();
    _rateSession();

    _controller = VideoPlayerController.asset('lib/src/assets/genshintro.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setVolume(0);
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width, //?? 0,
                height: _controller.value.size.height, //?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  visible: provider.showResources,
                  child: Text(
                    " ",
                    //"Studio & Helper \nfor Genshin",
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                    textAlign: TextAlign.center,
                  ),
                ),
                FadeInImage(
                    width: MediaQuery.of(context).size.width / 1.5,
                    image: AssetImage('lib/src/assets/gem.png'),
                    placeholder: AssetImage('lib/src/assets/gem.png')),
                Visibility(
                  visible: provider.showResources,
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        _controller.pause();

                        if (_isInterstitialAdReady && _checkPol2()) {
                          _interstitialAd?.show();
                        } else {
                          Navigator.pushNamed(context, '/second');
                        }
                      },
                      child: MyButton(data: 'Start'),
                    ),
                  ),
                ),
                //MyButton(data: 'Start', clastoNavigate: 'second')
                if (_isBannerAdReady && _bannerAd != null)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: _bannerAd?.size.width.toDouble(),
                      height: _bannerAd?.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }

  bool _checkPol2() {
    if (prefs.pol2 == 1) {
      return false;
    } else {
      return true;
    }
  }

  getdtaPolicy() {
//Getting the resp from the targeted
    if (Platform.isAndroid) {
      checkPolicyEachPlatform(
          'https://sites.google.com/view/genshin-gplay-policy/inicio');
    } else {
      checkPolicyEachPlatform(
          'https://sites.google.com/view/genshin-ios-policy/inicio');
    }
  }

  BannerAd setBannerAd() {
    return BannerAd(
      adUnitId: AdsHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
  }

  Future checkPolicyEachPlatform(String uri) async {
    final response = await http.Client().get(Uri.parse(uri));

    if (response.statusCode == 200) {
      //Getting the html document from the response
      try {
        if (response.body.toString().contains('Your consent 1')) {
          print('ENCONTRADOOOOOO TRUE');
          _incrementCounter('pol1', 1);
        } else {
          print('No encontrado :(');

          _incrementCounter('pol1', 0);
        }
        if (response.body.toString().contains('Contacting us 1')) {
          print('ENCONTRADOOOOOO 2 TRUE');
          _incrementCounter('pol2', 1);
        } else {
          print('No encontrado 2 :(');

          _incrementCounter('pol2', 0);
        }
      } catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }

  _incrementCounter(String field, int value) {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    if (field == 'pol1') {
      prefs.pol1 = value;
    } else if (field == 'pol2') {
      prefs.pol2 = value;
    }
    Future.delayed(const Duration(milliseconds: 1500), () {
      _changeProviderVisib(Provider.of<HomeProvider>(context, listen: false));
    });
  }

  _rateSession() {
    prefs.rateSession = 0;
  }

  _changeProviderVisib(HomeProvider provider) {
    provider.showResources = true;
  }

  void _loadInterstitialAd() {
    print('cargo el interstitial 1 ');
    InterstitialAd.load(
      adUnitId: AdsHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //navigate to next page or do something

              _isInterstitialAdReady = false;
              //_loadInterstitialAd();
              Navigator.pushNamed(context, '/second');
            },
          );

          _isInterstitialAdReady = true;
          print('interstitial 1 loaded');
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  Future<void> showTrackStatus() async {
    try {
      // If the system can show an authorization request dialog
      if (await AppTrackingTransparency.trackingAuthorizationStatus ==
          TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } on PlatformException {
      // Unexpected exception was thrown
    }
  }
}
