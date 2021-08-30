import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinwallp/src/ads/helper_ad.dart';
import 'package:genshinwallp/src/providers/ObsProviders/save_wp_provider.dart';
import 'package:genshinwallp/src/providers/bg_provider.dart';
import 'package:genshinwallp/src/sharedprefs/shared_prefs.dart';
import 'package:genshinwallp/src/widgets/item.dart';
import 'package:genshinwallp/src/widgets/rat/like_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:path_provider/path_provider.dart';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

class SaveLiveWallpaperPage extends StatefulWidget {
  @override
  _SaveLiveWallpaperPageState createState() => _SaveLiveWallpaperPageState();

  // SaveWallpaperPage({required this.isVisible});
}

class _SaveLiveWallpaperPageState extends State<SaveLiveWallpaperPage> {
  //var isVisible = true;
  late VideoPlayerController _controller;

  final InAppReview _inAppReview = InAppReview.instance;
  Availability _availability = Availability.LOADING;

  final prefs = new PreferenciasUsuario();

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();

    _loadInterstitialAd();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          if (isAvailable) {
            _availability = Availability.AVAILABLE;
          }
          /*&& !Platform.isAndroid
              ? Availability.AVAILABLE
              : Availability.UNAVAILABLE;*/
        });
        print("availability   ->   $_availability");
      } catch (e) {
        print("error availability rating ${Platform.environment}");
        setState(() => _availability = Availability.UNAVAILABLE);
      }
    });
  }

  Future<void> _requestReview() => _inAppReview.requestReview();

  @override
  Widget build(BuildContext context) {
    final LiveImg image = ModalRoute.of(context)!.settings.arguments as LiveImg;
    final String video = image.title;

    final provider = Provider.of<SaveWpProvider>(context);

    if (provider.canRate) {
      _requestReview();
      provider.canRate = false;
    }

    _controller =
        VideoPlayerController.asset('lib/src/assets/livewall/$video.mp4')
          ..initialize().then((_) {
            _controller.play();
            _controller.setVolume(0);
            _controller.setLooping(true);
            // Ensure the first frame is shown after the video is initialized
          });

    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                    image: AssetImage('lib/src/assets/bg.png'),
                    fit: BoxFit.cover),
                ClipRRect(
                  // Clip it cleanly.
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
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
                              visible: true,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _controller.pause();
                                      // _controller.dispose();
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ItemButton(
                                      text: 'Save',
                                      icon: Icons.download,
                                      bgColor: Colors.pink,
                                      onTap: () async {
                                        var status =
                                            await Permission.storage.status;
                                        if (status.isDenied ||
                                            status.isRestricted ||
                                            status.isLimited) {
                                          // You can request multiple permissions at once.
                                          Map<Permission, PermissionStatus>
                                              statuses = await [
                                            Permission.storage
                                          ].request();
                                          print(statuses[Permission
                                              .storage]); // it should print PermissionStatus.granted
                                        }
                                        _copyAssetToLocal(image.title);
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
                                child: VideoPlayer(_controller),
                                height:
                                    MediaQuery.of(context).size.height / 1.7,
                                width: MediaQuery.of(context).size.width / 1.4,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }

  /* Future setVisibility() {
    isVisible = false;
    return Future.delayed(Duration(milliseconds: 1000), () {
      isVisible = true;
    });
  }*/

  void _copyAssetToLocal(String video) async {
    try {
      var content = await rootBundle.load("lib/src/assets/livewall/$video.mp4");
      final directory = await getApplicationDocumentsDirectory();
      var file = File("${directory.path}/$video.mp4");
      file.writeAsBytesSync(content.buffer.asUint8List());
      GallerySaver.saveVideo(file.path);
      _showToast('Saving');
      checkDialog();
    } catch (e) {
      print("error saving video file ..... ");
    }
  }

  void checkDialog() {
    if (_checkPol()) {
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
/*
class LiveWallpaperSave extends StatefulWidget {
  const LiveWallpaperSave({
    Key? key,
    required String video,
  })  : video = video,
        super(key: key);

  final String video;

  @override
  _LiveWallpaperSaveState createState() => _LiveWallpaperSaveState();
}

class _LiveWallpaperSaveState extends State<LiveWallpaperSave> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print('lib/src/assets/${widget.video}.mp4');
    /* _controller = VideoPlayerController.asset('lib/src/assets/${widget.video}.mp4')
          ..initialize().then((_) {
            // _controller.play();
            _controller.setVolume(0);
            _controller.setLooping(true);
            // Ensure the first frame is shown after the video is initialized
*/
    setState(() {});
    //  });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text('${widget.video}' /*VideoPlayer(_controller)*/));
  }
}*/
