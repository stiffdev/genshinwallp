import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genshinwallp/src/pages/home/home_page.dart';
import 'package:genshinwallp/src/pages/menu/main_menu.dart';
import 'package:genshinwallp/src/pages/menu/menu_dos.dart';
import 'package:genshinwallp/src/pages/pagesmenu/characters/bg_selection_page.dart';
import 'package:genshinwallp/src/pages/pagesmenu/characters/characters_selection.dart';
import 'package:genshinwallp/src/pages/pagesmenu/codes/cod_page.dart';
import 'package:genshinwallp/src/pages/pagesmenu/codes/codes_page.dart';
import 'package:genshinwallp/src/pages/pagesmenu/livewallp/live2_wallp.dart';
import 'package:genshinwallp/src/pages/pagesmenu/livewallp/live_wallp_page.dart';
import 'package:genshinwallp/src/pages/pagesmenu/map/map_card.dart';
import 'package:genshinwallp/src/pages/pagesmenu/map/map_page.dart';
import 'package:genshinwallp/src/pages/pagesmenu/save/save_live.dart';
import 'package:genshinwallp/src/pages/pagesmenu/save/save_wall_page.dart';
import 'package:genshinwallp/src/pages/pagesmenu/tips/tips_page.dart';
import 'package:genshinwallp/src/pages/pagesmenu/wallpapers/wallp_selection_page.dart';
import 'package:genshinwallp/src/pages/second/second_page.dart';
import 'package:genshinwallp/src/providers/ObsProviders/home_provider.dart';
import 'package:genshinwallp/src/providers/ObsProviders/save_wp_provider.dart';
import 'package:genshinwallp/src/sharedprefs/shared_prefs.dart';
import 'package:genshinwallp/src/widgets/wallpaper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());

  //await SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaveWpProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Genshin',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => BackgroundVideo(),
          '/second': (BuildContext context) => SecondPage(),
          '/menu': (BuildContext context) => MainMenu(),
          '/menu2': (BuildContext context) => GridDashboard(),
          '/selbg': (BuildContext context) => BgSelectionPage(),
          '/wallsel': (BuildContext context) => WallpaperSelection(),
          '/selchar': (BuildContext context) => CharacterSelectionPage(),
          '/tips': (BuildContext context) => TipsPage(),
          '/saveWallp': (BuildContext context) => SaveWallpaperPage(),
          '/skinWallp': (BuildContext context) => WallpaperPage(),
          '/codes': (BuildContext context) => CodPage(),
          '/map': (BuildContext context) => MapPage(),
          '/live': (BuildContext context) => LiveWallpaperPage(),
          '/saveLive': (BuildContext context) => SaveLiveWallpaperPage(),
          '/mapdetail': (BuildContext context) => CardMap(),
        },
      ),
    );
  }
}
