import 'dart:async';
import 'package:flutter/material.dart';

class BgProvider extends ChangeNotifier {
  int current = 0;
  int last = 5;

  List<String> images = [
    'https://i.ibb.co/1d7NNrJ/1-6708.jpg',
    'https://i.ibb.co/Q9QFrVj/1-6710.jpg',
    'https://i.ibb.co/LY1vZQH/1-6921.jpg',
    'https://i.ibb.co/XshcM4P/1-6932.jpg',
    'https://i.ibb.co/jWxVgj7/1-7761.jpg',
    'https://i.ibb.co/H2BSB9q/1-7764.jpg',
    'https://i.ibb.co/3BXzgcY/1-7765.jpg',
    'https://i.ibb.co/0MQKPbm/1-7766.jpg',
    'https://i.ibb.co/q7hQH7w/1-7804.jpg',
    'https://i.ibb.co/2sdQRPJ/1-8096.jpg',
    'https://i.ibb.co/CMc275T/1-8097.jpg',
    'https://i.ibb.co/K73L6W1/1-8099.jpg',
    'https://i.ibb.co/VVz1PQd/1-8100.jpg',
    'https://i.ibb.co/2Ygf15G/1-8101.jpg',
    'https://i.ibb.co/16FMTVc/1-80983.jpg',
    'https://i.ibb.co/hgJTwM6/925844.jpg',
    'https://i.ibb.co/kKrZbWN/genshin-impact-6920.jpg',
    'https://i.ibb.co/CMCXw4h/genshin-impact-perso-Gzo-VW.jpg',
    'https://i.ibb.co/Wp1RnfJ/thumb-1920-136870.jpg',
    'https://i.ibb.co/J3nDdcw/thumb-1920-142660.jpg',
    'https://i.ibb.co/PcbWfTn/thumb-1920-142664.jpg',
    'https://i.ibb.co/MPDdPs1/thumb-1920-142723.jpg',
    'https://i.ibb.co/GWrzmLd/thumb-1920-887943.jpg',
    'https://i.ibb.co/ykccLy4/thumb-1920-900538.jpg',
    'https://i.ibb.co/41c7TDS/thumb-1920-904441.jpg',
    'https://i.ibb.co/8j2x89S/thumb-1920-904451.jpg',
    'https://i.ibb.co/0B7zCRP/thumb-1920-905076.jpg',
    'https://i.ibb.co/KbvqNVQ/thumb-1920-905116.jpg',
    'https://i.ibb.co/s3vKKdZ/thumb-1920-907751.jpg',
    'https://i.ibb.co/mS9XHNq/thumb-1920-908342.jpg',
    'https://i.ibb.co/QNCLRdT/thumb-1920-910453.jpg',
    'https://i.ibb.co/n1pWt4C/thumb-1920-911895.jpg',
    'https://i.ibb.co/SBsNrJ0/thumb-1920-912311.jpg',
    'https://i.ibb.co/fYT5201/thumb-1920-913753.jpg',
    'https://i.ibb.co/tHK6nDP/thumb-1920-916250.jpg',
    'https://i.ibb.co/RY6qvDL/thumb-1920-916299.jpg',
    'https://i.ibb.co/55ZX0PJ/thumb-1920-916799.jpg',
    'https://i.ibb.co/Ch283LF/thumb-1920-918134.jpg',
    'https://i.ibb.co/TL40sY5/thumb-1920-918288.jpg',
    'https://i.ibb.co/CMKgkjc/thumb-1920-918637.jpg',
    'https://i.ibb.co/zfSgLPq/thumb-1920-918758.jpg',
    'https://i.ibb.co/7Gwn7Wg/thumb-1920-918848.jpg',
    'https://i.ibb.co/bNMCTzP/thumb-1920-918917.jpg',
    'https://i.ibb.co/J2pfgy3/thumb-1920-922514.jpg',
    'https://i.ibb.co/8XTSK7p/thumb-1920-922581.jpg',
    'https://i.ibb.co/PMvdNFP/thumb-1920-922702.jpg',
    'https://i.ibb.co/tXH90Jw/thumb-1920-922920.jpg',
    'https://i.ibb.co/dbVk2YY/thumb-1920-923050.jpg',
    'https://i.ibb.co/smWvLtq/thumb-1920-923118.jpg',
    'https://i.ibb.co/LQWGwnV/thumb-1920-923175.jpg',
    'https://i.ibb.co/3SGVD0g/thumb-1920-923443.jpg',
    'https://i.ibb.co/vc1dtkW/thumb-1920-923450.jpg',
    'https://i.ibb.co/jDRxqwW/thumb-1920-923454.jpg',
    'https://i.ibb.co/c8n3qX5/thumb-1920-923634.jpg',
    'https://i.ibb.co/hmLy7dC/thumb-1920-923841.jpg',
    'https://i.ibb.co/8sX8Htb/thumb-1920-924049.jpg',
    'https://i.ibb.co/pzGVx11/thumb-1920-924061.jpg',
    'https://i.ibb.co/jZYrhBc/thumb-1920-924323.jpg',
    'https://i.ibb.co/5W1G8H3/thumb-1920-924350.jpg',
    'https://i.ibb.co/sy1K66g/thumb-1920-924356.jpg',
    'https://i.ibb.co/PG8TX31/thumb-1920-924493.jpg',
    'https://i.ibb.co/HN72ckM/thumb-1920-924608.jpg',
    'https://i.ibb.co/3hs8X3s/thumb-1920-924617.jpg',
    'https://i.ibb.co/tXbDx3w/thumb-1920-924709.jpg',
    'https://i.ibb.co/Hhfhy4v/thumb-1920-924811.jpg',
    'https://i.ibb.co/vhSBxcx/thumb-1920-924822.jpg',
    'https://i.ibb.co/dJ9yjCw/thumb-1920-924998.jpg',
    'https://i.ibb.co/VHHTRFM/thumb-1920-925006.jpg',
    'https://i.ibb.co/r37FCZS/thumb-1920-925179.jpg',
    'https://i.ibb.co/vvQsRsP/thumb-1920-925184.jpg',
    'https://i.ibb.co/tZ9hVBC/thumb-1920-925187.jpg',
    'https://i.ibb.co/ZzGTXy7/thumb-1920-925188.jpg',
    'https://i.ibb.co/wrMmrrg/thumb-1920-925193.jpg',
    'https://i.ibb.co/MsYht6m/thumb-1920-925196.jpg',
    'https://i.ibb.co/N6SfKt6/thumb-1920-925198.jpg',
    'https://i.ibb.co/kcmFzft/thumb-1920-925200.jpg',
    'https://i.ibb.co/DtGzm6S/thumb-1920-925201.jpg',
    'https://i.ibb.co/Y8dsTs4/thumb-1920-925202.jpg',
    'https://i.ibb.co/0n9Bb39/thumb-1920-925203.jpg',
    'https://i.ibb.co/0f3PkJf/thumb-1920-925204.jpg',
    'https://i.ibb.co/1RNVz21/thumb-1920-925211.jpg',
    'https://i.ibb.co/LryY2w3/thumb-1920-925237.jpg',
    'https://i.ibb.co/qyJNn20/thumb-1920-925290.jpg',
    'https://i.ibb.co/bvQGBBx/thumb-1920-925310.jpg',
    'https://i.ibb.co/DLnRwz3/thumb-1920-925446.jpg',
    'https://i.ibb.co/f0XHSNg/thumb-1920-925451.jpg',
    'https://i.ibb.co/hVD5dRG/thumb-1920-925551.jpg',
    'https://i.ibb.co/YRjg1zd/thumb-1920-925554.jpg',
    'https://i.ibb.co/KFczd9q/thumb-1920-925555.jpg',
    'https://i.ibb.co/KwzHrhd/thumb-1920-925556.jpg',
    'https://i.ibb.co/QKwhwTF/thumb-1920-925566.jpg',
    'https://i.ibb.co/gMB4nyM/thumb-1920-925623.jpg',
    'https://i.ibb.co/6yDnQSM/thumb-1920-925695.jpg',
    'https://i.ibb.co/Std6Snv/thumb-1920-925748.jpg',
    'https://i.ibb.co/mCrJhbw/thumb-1920-925749.jpg',
    'https://i.ibb.co/N6kD1Ms/thumb-1920-925810.jpg',
    'https://i.ibb.co/8DwPn8h/thumb-1920-925836.jpg',
    'https://i.ibb.co/T1ZD4MP/thumb-1920-925837.jpg',
    'https://i.ibb.co/3st0pqy/thumb-1920-925839.jpg',
    'https://i.ibb.co/NFYTzrM/thumb-1920-925840.jpg',
    'https://i.ibb.co/CMXXqpt/thumb-1920-925843.jpg',
    'https://i.ibb.co/TgqZHZb/thumb-1920-925845.jpg',
    'https://i.ibb.co/M5hqrdX/thumb-1920-925847.jpg',
    'https://i.ibb.co/ZHcGdNb/thumb-1920-925848.jpg',
    'https://i.ibb.co/GPTKdjQ/thumb-1920-925849.jpg',
    'https://i.ibb.co/d6zndyD/thumb-1920-925850.jpg',
    'https://i.ibb.co/VvpzmMN/thumb-1920-925851.jpg',
    'https://i.ibb.co/jvmhDpS/thumb-1920-925853.jpg',
    'https://i.ibb.co/jvKYJsZ/thumb-1920-925865.jpg',
    'https://i.ibb.co/KbwcxQq/thumb-1920-926045.jpg',
    'https://i.ibb.co/jD9vp5y/thumb-1920-926059.jpg',
    'https://i.ibb.co/MMBTxsT/thumb-1920-926064.jpg',
    'https://i.ibb.co/nBwcq6t/thumb-925553.jpg',
    'https://i.ibb.co/JCdFztB/thumb-925566.jpg',
    'https://i.ibb.co/YbYsLX8/thumb-925589.jpg',
    'https://i.ibb.co/020d3K3/thumb-1920-925439.jpg',
    'https://i.ibb.co/GtTjTwq/thumb-1920-925660.jpg',
    'https://i.ibb.co/Sr43JPd/thumb-925537.jpg',
    'https://i.ibb.co/G3Hw26W/wp7487031-genshin-im-t-MV2-S.jpg',
    'https://i.ibb.co/wWB2PH6/xiao-de-genshin-impa-y8-Zf-E.jpg',
    'https://i.ibb.co/PhnWvhd/zhongli-dragon-de-ge-Naw-Mp.jpg',
  ];

  List<String> backgrounds = [
    'https://i.ibb.co/GcbVK7q/6b65269931620efad860be5bf41ba3ff.jpg',
    'https://i.ibb.co/CPf5W71/9aa0304a4145b67b805a859f9ab4e532.jpg',
    'https://i.ibb.co/W6FXXZx/17b5be3026bf288e2d27c3f27ebf9503.jpg',
    'https://i.ibb.co/56qpd5v/65feb565bddcabce7affff0f1870b63f.jpg',
    'https://i.ibb.co/pfNF2Ls/70f4aebb3119c12b400149241a85eafb.jpg',
    'https://i.ibb.co/j3gTQjZ/96c4a45586df1ad9286d3dbe9376a6ff.jpg',
    'https://i.ibb.co/x56qHTG/80565751a20f861bd71d1ad0fbef4ed5.jpg',
    'https://i.ibb.co/sCjZ695/adeec09c9d2da88b6dafbe6a7bf51214.jpg',
    'https://i.ibb.co/0Vn4DxT/anime-girls-genshin-impact-ningguang-genshin-impact-hd-wallpaper-preview.jpg',
    'https://i.ibb.co/PZPyR5V/anime-sky-landscape-clouds-portrait-display-hd-wallpaper-preview.jpg',
    'https://i.ibb.co/7JSM0k3/c8babd659ced774aa332e3181632978c.jpg',
    'https://i.ibb.co/nrbwsQc/d9a70f3ea2f8081729a984b3adb68ab8.jpg',
    'https://i.ibb.co/XYDz72F/d77e800fb45fe462da55c62083b1001b.jpg',
    'https://i.ibb.co/wRZdtCp/e653f5f2b28067b4d36fb537f2679ee4.jpg',
    'https://i.ibb.co/7NxzHPs/genshin-impact-mobil-n47-SX.jpg',
    'https://i.ibb.co/xDc09S8/genshin-impact-xiao-X5-Yt-R.jpg',
    'https://i.ibb.co/8NQTPzR/screen-1.jpg',
    'https://i.ibb.co/vP7xL9X/wallpaper2you-53428.jpg',
    'https://i.ibb.co/LQmg7JY/wp4814695.jpg',
    'https://i.ibb.co/BzMkCvX/wp7487048-genshin-im-s-Zx-OQ.jpg',
    'https://i.ibb.co/ykccLy4/thumb-1920-900538.jpg',
    'https://i.ibb.co/G3Hw26W/wp7487031-genshin-im-t-MV2-S.jpg',
    'https://i.ibb.co/PQnJfJk/fondo-luces-neon-rea-NIJFg.jpg',
    'https://i.ibb.co/Std6Snv/thumb-1920-925748.jpg',
    'https://i.ibb.co/0f3PkJf/thumb-1920-925204.jpg',
    'https://i.ibb.co/MsYht6m/thumb-1920-925196.jpg',
    'https://i.ibb.co/r37FCZS/thumb-1920-925179.jpg',
    'https://i.ibb.co/GWrzmLd/thumb-1920-887943.jpg',
    'https://i.ibb.co/s3vKKdZ/thumb-1920-907751.jpg',
    'https://i.ibb.co/QNCLRdT/thumb-1920-910453.jpg',
    'https://i.ibb.co/hFnfHdY/fe7fbf78a0d29a8244fb7073b44bc998.jpg',
    'https://i.ibb.co/n1pWt4C/thumb-1920-911895.jpg',
    'https://i.ibb.co/WkmzW9Q/1574974c08fc9d92af20-q1i-MU.jpg',
    'https://i.ibb.co/J3nDdcw/thumb-1920-142660.jpg',
  ];

  List<String> lives = [
    'https://i.ibb.co/ZdkrmLT/ezgif-frame-001-1.jpg', //live1
    'https://i.ibb.co/TY8hWzd/ezgif-frame-00.jpg', //live2
    'https://i.ibb.co/9V6kVXc/ezgif-frame-001tm-1.jpg', //live3
    'https://i.ibb.co/wWT9hLp/ezfgif-frame-001-1.jpg', //live4
    'https://i.ibb.co/RNmFNr5/ezgiffg-frame-001-1.jpg', //live5
    'https://i.ibb.co/jJD1JDV/ezfsgif-frame-001-1.jpg', //live6
    'https://i.ibb.co/yk8g6k2/ezfsasgif-frame-001-1.jpg', //live7
    'https://i.ibb.co/SJ4BB3H/ezgdaif-frame-001-1.jpg', //live8
    'https://i.ibb.co/72qCYfn/ezgif-frcdsame-001-1.jpg', //live9
    'https://i.ibb.co/GWkG2Yd/ezsdagif-frame-020.jpg', //live10
    'https://i.ibb.co/Ph12cVt/ezagdaif-frame-001-1.jpg', //live11
    'https://i.ibb.co/9Tbdj2c/ezgif-frame-001.jpg', //live12
    'https://i.ibb.co/fpjZmhH/ezgif-frame-001.jpg', //live13
    'https://i.ibb.co/Fm2FBmD/ezgif-frame-0fd.jpg', //live14
  ];

  List<LiveImg> livesImg = [
    LiveImg(
        title: 'livewall1',
        image: 'https://i.ibb.co/ZdkrmLT/ezgif-frame-001-1.jpg'),
    LiveImg(
        title: 'livewall2',
        image: 'https://i.ibb.co/TY8hWzd/ezgif-frame-00.jpg'),
    LiveImg(
        title: 'livewall3',
        image: 'https://i.ibb.co/9V6kVXc/ezgif-frame-001tm-1.jpg'),
    LiveImg(
        title: 'livewall4',
        image: 'https://i.ibb.co/wWT9hLp/ezfgif-frame-001-1.jpg'),
    LiveImg(
        title: 'livewall5',
        image: 'https://i.ibb.co/RNmFNr5/ezgiffg-frame-001-1.jpg'),
    LiveImg(
        title: 'livewall6',
        image: 'https://i.ibb.co/jJD1JDV/ezfsgif-frame-001-1.jpg'),
    LiveImg(
        title: 'livewall7',
        image: 'https://i.ibb.co/yk8g6k2/ezfsasgif-frame-001-1.jpg'),
    LiveImg(
        title: 'livewall8',
        image: 'https://i.ibb.co/SJ4BB3H/ezgdaif-frame-001-1.jpg'),
    LiveImg(
        title: 'livewall9',
        image: 'https://i.ibb.co/72qCYfn/ezgif-frcdsame-001-1.jpg'),
    LiveImg(
        title: 'livewall10',
        image: 'https://i.ibb.co/GWkG2Yd/ezsdagif-frame-020.jpg'),
    LiveImg(
        title: 'livewall11',
        image: 'https://i.ibb.co/Ph12cVt/ezagdaif-frame-001-1.jpg'),
    LiveImg(
        title: 'livewall12',
        image: 'https://i.ibb.co/9Tbdj2c/ezgif-frame-001.jpg'),
    LiveImg(
        title: 'livewall13',
        image: 'https://i.ibb.co/fpjZmhH/ezgif-frame-001.jpg'),
    LiveImg(
        title: 'livewall14',
        image: 'https://i.ibb.co/Fm2FBmD/ezgif-frame-0fd.jpg'),
  ];
}

class LiveImg {
  String title;
  String image;

  LiveImg({
    required this.title,
    required this.image,
  });
}
