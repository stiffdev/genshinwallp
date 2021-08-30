class AdsHelper {
  static String get bannerAdUnitId {
    /* if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {*/
    return 'ca-app-pub-3940256099942544/6300978111';
    /* } else {
      throw new UnsupportedError('Unsupported platform');
    }*/
  }

  static String get interstitialAdUnitId {
    return 'ca-app-pub-3940256099942544/1033173712';
  }

  static String get rewardedAdUnitId {
    return 'ca-app-pub-3940256099942544/79999552160883';
  }
}
