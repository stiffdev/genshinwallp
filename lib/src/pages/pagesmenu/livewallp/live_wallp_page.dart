import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:genshinwallp/src/pages/pagesmenu/save/save_live.dart';
import 'package:genshinwallp/src/providers/bg_provider.dart';
import 'package:genshinwallp/src/widgets/back_button.dart';
import 'package:genshinwallp/src/widgets/card_live_wallp.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class LiveWallpaperPage extends StatefulWidget {
  @override
  _LiveWallpaperPageState createState() => _LiveWallpaperPageState();
}

class _LiveWallpaperPageState extends State<LiveWallpaperPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: _widgetBackground(),
      child: SafeArea(
        //child: _gridViewDemo(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainBackButton(),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Select live wallpaper",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway')),
                  ),
                ),
              ],
            ),
            Expanded(child: _gridViewDemo(context))
          ],
        ),
      ),
    ));
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

Widget _gridViewDemo(BuildContext context) {
  return Container(
    child: GridView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 0.7),
        children: __gridViewChildCustom(context)),
  );
}

_getImage(videoPathUrl) async {
  var thub = await VideoThumbnail.thumbnailData(
    video: 'lib/src/assets/genshintro.mp4',
    imageFormat: ImageFormat.JPEG,
    maxWidth:
        128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
    quality: 25,
  );
  return thub;
}

Widget _getImgFrimThumb(String thumb) {
  //nueva instancia del provider
  return FutureBuilder<Uint8List>(
    future: _getImage(thumb),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return Image.memory(snapshot.data as Uint8List);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

class _ButterFlyAssetVideo extends StatefulWidget {
  String video;

  _ButterFlyAssetVideo(this.video);
  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<_ButterFlyAssetVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  // _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> __gridViewChildCustom(BuildContext context) {
  final provider = new BgProvider();

  List<Widget> children = [];
  for (int index = 0; index < provider.livesImg.length; index++) {
    children.add(GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              //Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
              context,
              '/saveLive',
              arguments: provider.livesImg[index]);

          /*  Navigator.pushNamed(
              //Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
              context,
              '/skinWallp',
              arguments: ScreenArguments(skin, provider.backgrounds[index]));*/
        },
        child: CardLiveWallpaper(
            image: provider
                .livesImg[index]) /*CardLive(image: provider.lives[index])*/));
  }
  return children;
}
