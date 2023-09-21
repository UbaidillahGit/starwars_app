import 'dart:io';

class MyHttpOverrides extends HttpOverrides{

  @override
  createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}