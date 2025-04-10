import 'dart:async';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duracion = Duration(seconds: 3);
    return new Timer(duracion, irlogin);
  }

  irlogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff0391fd),
              gradient: LinearGradient(
                  colors: [Color(0xFF0071CE), Color(0xFF0071CE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% del ancho de la pantalla
                height: MediaQuery.of(context).size.height *
                    0.8, // 80% del alto de la pantalla
                child: Image.asset(
                  "assets/images/wal.png",
                  fit: BoxFit.contain, // Se ajusta sin sobrepasar los límites)
                )),
          ),
        ],
      ),
    );
  }
}
