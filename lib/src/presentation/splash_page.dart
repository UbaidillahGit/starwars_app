import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starwars_app/src/presentation/home/home_page.dart';
import 'package:starwars_app/src/presentation/no_connection_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  bool _visible = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _setParam();
    _chcekConnection();
  }

  void _setParam () async {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _visible = true);
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() => _loading = true);
    });
  }

  void _chcekConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print('connected');
        }
        _routeHome();
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print('not connected');
      }
      _routeNoConnection();
    }
  }

  void _routeHome() { ///_______ REDIRECT HERE WHEN USER HAVE INTERNET CONNECTION
    Future.delayed(const Duration(seconds: 4), () 
      => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) 
        => const HomePage()), (route) => false));}
  
  void _routeNoConnection() { ///_______ REDIRECT HERE WHEN USER DOES NOT HAVE INTERNET CONNECTION
    Future.delayed(const Duration(seconds: 4), () 
      => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) 
        => const NoConnectionPage()), (route) => false));}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash.jpeg'),
                fit: BoxFit.cover
              )
            ),
          ),
          Positioned(
            top: 80,
            left: MediaQuery.of(context).size.width / 7,
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0, 
              duration: const Duration(milliseconds: 3000),
              child: const Text(
                'Star Wars',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'Starjhol'
                ),
              )
            ),
          ),
          
          _loading 
          ? Positioned(
            bottom: 10,
            left:MediaQuery.of(context).size.width / 2.3,
            child: const Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Starjedi'
              ),
            )
          )
          : Container()
        ],
      ),
    );
  }
}