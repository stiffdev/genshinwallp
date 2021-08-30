import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String data;
  final String? clastoNavigate;

  MyButton({required this.data, this.clastoNavigate});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      /*child: InkWell(
        onTap: () {
          if (clastoNavigate != null) {
            Navigator.pushNamed(context, clastoNavigate!);
          }
        },*/
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.pink]),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 48),
            Expanded(
              child: Center(
                child: Text(
                  data,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 48.0,
              child: Icon(
                Icons.navigate_next,
                color: Colors.white,
                size: 23.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
