import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinwallp/src/ads/helper_ad.dart';
import 'package:genshinwallp/src/providers/ObsProviders/save_wp_provider.dart';
import 'package:genshinwallp/src/sharedprefs/shared_prefs.dart';
import 'package:genshinwallp/src/widgets/back_button.dart';
import 'package:genshinwallp/src/widgets/item.dart';
import 'package:genshinwallp/src/widgets/rat/like_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:launch_review/launch_review.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class WallpaperPage extends StatefulWidget {
  @override
  _WallpaperPageState createState() => _WallpaperPageState();

  // SaveWallpaperPage({required this.isVisible});
}

class _WallpaperPageState extends State<WallpaperPage> {
  static GlobalKey previewContainer = new GlobalKey();
  final _screenshotController = ScreenshotController();
  var isVisible = true;

  final prefs = new PreferenciasUsuario();

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments argumen =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    final provider = Provider.of<SaveWpProvider>(context);

    if (provider.canRate) {
      LaunchReview.launch(
        androidAppId: "com.skin.creator.genshin.live.wallpapers.wish.codes.map",
        iOSAppId: "",
      );
      provider.canRate = false;
    }

    return Scaffold(
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(argumen.wallpaperUrl, fit: BoxFit.cover),
                  ClipRRect(
                    // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.all(35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: isVisible,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MainBackButton(),
                                    ItemButton(
                                        text: 'Save',
                                        icon: Icons.download,
                                        bgColor: Colors.pink,
                                        onTap: () async {
                                          provider.showDialog = true;

                                          //_requestReview();
                                          //_openStoreListing();
                                          var status =
                                              await Permission.storage.status;
                                          if (status.isDenied ||
                                              status.isRestricted ||
                                              status.isLimited) {
                                            // You can request multiple permissions at once.
                                            print('no permission');
                                            Map<Permission, PermissionStatus>
                                                statuses = await [
                                              Permission.storage
                                            ].request();
                                            print(statuses[Permission
                                                .storage]); // it should print PermissionStatus.granted
                                          } else {
                                            print(' permission');
                                            // doScreen(); //TODO remove comment for this line
                                          }
                                          doScreen(); //TODO REMOVE COMMENT
                                        })
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 10)),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                argumen.wallpaperUrl),
                                            fit: BoxFit.cover)),
                                    child: FadeInImage(
                                      image: AssetImage(argumen.skin),
                                      placeholder: AssetImage(
                                          'lib/src/assets/no-image.jpg'),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      //fit: BoxFit .cover //LA IMAGEN SE ADAPTE AL ANCHO
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future setVisibility() {
    isVisible = false;
    return Future.delayed(Duration(milliseconds: 1000), () {
      isVisible = true;
    });
  }

  void checkDialog() {
    if (_checkPol()) {
      //check p1

      if (prefs.rateSession == 0 && prefs.ratedPrev == 0) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Do you like the app?",
                descriptions: "Your opinion is important for us",
                text: "",
              );
            });
      } else {
        //check p2 for anunc
        if (_checkPol2()) {
          if (_isInterstitialAdReady) {
            print('entro should show ad pq mierds no aparece');
            _interstitialAd?.show();
          } else {
            print('error not ready');
          }
        }
      }
    } else {
      //check p2 for anunc
      if (_checkPol2()) {
        if (_isInterstitialAdReady) {
          _interstitialAd!.show();
        } else {
          print('entro aquiiii3');
          print('not loaded pero p2');
        }
      } else {
        print('p1 mal y p2 igual');
      }
    }
    /* if (Provider.of<SaveWpProvider>(context, listen: false).showDialog ==
        true) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Do you like the app?",
              descriptions: "Your opinion is important for us",
              text: "",
            );
          });
    }*/
  }

  Future<void> doScreen() async {
    setState(() {
      isVisible = false;
    });
    await _screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        // if (Platform.isAndroid) {
        await ImageGallerySaver.saveImage(Uint8List.fromList(image),
            quality: 90);
        // }

        /// Share Plugin
        ///
        //  await Share.shareFiles([imagePath.path]);
        /* if (prefs.rateSession == 0 && prefs.ratedPrev == 0) {
          //ratsession se pone a 1 cuando toca la face rat
          //ratPrev solo pone a 1 cuando toca la face green
          checkDialog();
        }*/
        checkDialog();
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            _showToast('Saving...');

            isVisible = true;
          });
        });
      }
    });
  }

  bool _checkPol() {
    if (prefs.pol1 == 1) {
      return false;
    } else {
      return true;
    }
  }

  bool _checkPol2() {
    if (prefs.pol2 == 1) {
      return false;
    } else {
      return true;
    }
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

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[600],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class ScreenArguments {
  final String skin;
  final String wallpaperUrl;

  ScreenArguments(this.skin, this.wallpaperUrl);
}
