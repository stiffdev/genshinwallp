import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genshinwallp/src/model/constants.dart';
import 'package:genshinwallp/src/providers/ObsProviders/save_wp_provider.dart';
import 'package:genshinwallp/src/sharedprefs/shared_prefs.dart';
import 'package:provider/provider.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;

  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.text})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      prefs.rateSession = 1;
                      Navigator.of(context).pop();
                    },
                    child: Image(
                        image: AssetImage('lib/src/assets/dislike.png'),
                        width: MediaQuery.of(context).size.width / 5),
                  ),
                  GestureDetector(
                    onTap: () {
                      prefs.rateSession = 1;
                      Navigator.of(context).pop();
                    },
                    child: Image(
                        image: AssetImage('lib/src/assets/neutral.png'),
                        width: MediaQuery.of(context).size.width / 5),
                  ),
                  GestureDetector(
                    onTap: () {
                      prefs.rateSession = 1;
                      prefs.ratedPrev = 1;
                      Provider.of<SaveWpProvider>(context, listen: false)
                          .canRate = true;
                      Navigator.of(context).pop();
                    },
                    child: Image(
                        image: AssetImage('lib/src/assets/like.png'),
                        width: MediaQuery.of(context).size.width / 5),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              /*Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 18),
                    )),
              ),*/
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("lib/src/assets/code.png")),
          ),
        ),
      ],
    );
  }
}
