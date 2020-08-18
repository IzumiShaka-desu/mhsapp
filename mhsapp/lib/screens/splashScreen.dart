
import 'package:flutter/material.dart';
import 'package:mhsapp/const.dart';
import 'package:mhsapp/screens/dashboard.dart';
import 'package:mhsapp/screens/home.dart';
import 'package:mhsapp/service/sfService.dart';
import 'package:mhsapp/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate=false;
  setFull() {
    setState(() {
     isAnimate=true;
    });
  }

  @override
  void initState() {
    super.initState();
    
    delayMethod(2940, setFull);
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
              color: Colors.white,
          child: Center(
            child: FlutterLogo(
              size: 150,
            ),
          ),
        )),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          top: (isAnimate)?-height:-2,
          left: (isAnimate)?-width:-2,
                  child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            
            decoration: BoxDecoration(color:primaryGreen,shape: BoxShape.circle),
            height: (isAnimate)?height*3:0,
            width: (isAnimate)?width*3:0,
            onEnd: ()=>gotoHome(),
          ),
        )
      ],
    );
  }
  void gotoHome() async{
   ( await SfService().getLoginStat())?Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Dashboard())):
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }
}
