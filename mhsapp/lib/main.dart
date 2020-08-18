
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhsapp/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryTextTheme: GoogleFonts.poppinsTextTheme(), primarySwatch: Colors.blue,visualDensity: VisualDensity.adaptivePlatformDensity,),
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}