import 'package:flutter/material.dart';
import 'package:genshinwallp/src/model/Tip.dart';
import 'package:genshinwallp/src/providers/tips_provider.dart';
import 'package:genshinwallp/src/widgets/back_button.dart';
import 'package:genshinwallp/src/widgets/card_swiper.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final tipsProvider = new TipsProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: _widgetBackground(),
          padding: EdgeInsets.only(top: 20),
          child: SafeArea(
              child: Column(
            children: [
              Row(
                children: [
                  MainBackButton(),
                ],
              ),
              //  Expanded(child:
              _swiperTarjetas()
              // )
            ],
          ))),
    );
  }

  BoxDecoration _widgetBackground() {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            "https://preview.redd.it/dwgetie8y5971.png?auto=webp&s=f1c930259ac1cd143a024df0152ba2caabad1d35"),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: tipsProvider.processResponse(),
      builder: (BuildContext context, AsyncSnapshot<List<Tip>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(tips: snapshot.data!);
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
