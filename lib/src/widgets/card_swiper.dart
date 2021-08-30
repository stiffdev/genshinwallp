import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:genshinwallp/src/model/Tip.dart';

class CardSwiper extends StatelessWidget {
  // const CardSwiper({ Key? key }) : super(key: key);

  final List<Tip> tips;

  CardSwiper(
      {required this.tips}); //indico que me tienen que mandar sí o sí la lista de peliculas

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
          child: new Swiper(
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          tips[index].uniqueId =
              '${tips[index].uniqueId!}-tarjeta'; //OJOOOOOOOOOOOOOOOOOOOOO
          return Hero(
            tag: tips[index].uniqueId!,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  color: Colors.white,
                  child: CustomScrollView(slivers: [
                    _crearAppBar(index, context),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            tips[index].title!,
                            style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 50),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Text(
                                tips[index].text!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway'),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    // )
                  ]),
                )),
          );
        },
        indicatorLayout: PageIndicatorLayout.SCALE,
        autoplay: false,
        autoplayDelay: 1000,
        itemWidth: _screenSize.width * 0.9,
        itemHeight: _screenSize.height * 0.8,
        itemCount: tips.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        fade: 1.0,
        viewportFraction: 0.85,
      )),
    );
  }

  _crearImagen(int index, BuildContext context) {
    final image = FadeInImage(
        image: NetworkImage(tips[index].image!),
        placeholder: AssetImage('lib/src/assets/no-image.jpg'),
        fit: BoxFit.cover //LA IMAGEN SE ADAPTE AL ANCHO
        );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: tips[index]);
      },
      child: image,
    );
  }

  Widget _crearAppBar(int index, BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        /* centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
          textAlign: TextAlign.center,
        ),*/
        background: FadeInImage(
          image: NetworkImage(tips[index].image!),
          placeholder: AssetImage('lib/src/assets/gensihoriz.jpeg'),
          fadeInDuration: Duration(milliseconds: 2000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


/*  */