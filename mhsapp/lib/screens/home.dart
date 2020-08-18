import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mhsapp/const.dart';
import 'package:mhsapp/models/message.dart';
import 'package:mhsapp/service/base.dart';
import 'package:mhsapp/service/sfService.dart';
import 'package:mhsapp/utils.dart';

import 'dashboard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, TextEditingController> controller = {
    'emailLogin': TextEditingController(),
    'emailRegister': TextEditingController(),
    'fullname': TextEditingController(),
    'passwordLogin': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'password': TextEditingController(),
  };
  setControllerEmpty() {
    for (String i in controller.keys) {
      controller[i].text = '';
    }
  }

  bool isSuccessfull = false;
  PageController _pageController = PageController();
  double currentPageValue = 0;
  bool isLoading = false;
  GlobalKey<ScaffoldState> sk = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    return Stack(children: [
      Positioned.fill(
            child: Container(
             
        )),
        Scaffold(
              key: sk,
              body: Stack(children: [
                Positioned.fill(
                    child: Container(
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: 2,
                    itemBuilder: (context, position) {
                      if (position == currentPageValue.floor()) {
                        return Transform(
                            transform: Matrix4.identity()
                              ..rotateZ(currentPageValue - position),
                            child: (position == 0)
                                ? Stack(children: [
                                    Positioned.fill(
                                      child: Container(
                                          color: primaryGreen,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height / 8),
                                              child: Column(children: [
                                                Container(
                                                  child: FlutterLogo(size: 50),
                                                ),
                                                SizedBox(height: 25),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'emailLogin'],
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon: Icon(
                                                                  Icons.email),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  ' Email')),
                                                ),
                                                SizedBox(height: 25),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'passwordLogin'],
                                                      obscureText: true,
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'password')),
                                                ),
                                              ]),
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.58),
                                        child: InkWell(
                                            onTap: () => (!isLoading)
                                                ? loginAct(
                                                    controller['emailLogin']
                                                        .text,
                                                    controller['passwordLogin']
                                                        .text)
                                                : {debugPrint('isloading')},
                                            child: AnimatedContainer(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                padding: EdgeInsets.all(15),
                                                duration:
                                                    Duration(milliseconds: 200),
                                                child: (isLoading)
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Text(
                                                        '      Login        ',
                                                        style: TextStyle(
                                                            color: primaryBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                      ),
                                    ),
                                  ])
                                : Stack(children: [
                                    Positioned.fill(
                                      child: Container(
                                          color: primaryBlue,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height / 8),
                                              child: Column(children: [
                                                Container(
                                                  child: FlutterLogo(
                                                    size: 50,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'fullname'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .perm_identity),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'fullname')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'emailRegister'],
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon: Icon(
                                                                  Icons.email),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Email')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      obscureText: true,
                                                      controller: controller[
                                                          'password'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'password')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      obscureText: true,
                                                      controller: controller[
                                                          'confirmPassword'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'confirm password')),
                                                )
                                              ]),
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.68),
                                        child: InkWell(
                                            onTap: () => (!isLoading)
                                                ? registerAct(
                                                    controller['emailRegister']
                                                        .text,
                                                    controller['password'].text,
                                                    controller['fullname'].text,
                                                    controller[
                                                            'confirmPassword']
                                                        .text)
                                                : {debugPrint('isloading')},
                                            child: AnimatedContainer(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                padding: EdgeInsets.all(15),
                                                duration:
                                                    Duration(milliseconds: 200),
                                                child: (isLoading)
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Text(
                                                        '     Register       ',
                                                        style: TextStyle(
                                                            color: primaryBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                      ),
                                    )
                                  ]));
                      } else if (position == currentPageValue.floor() + 1) {
                        return Transform(
                            transform: Matrix4.identity()
                              ..rotateZ(currentPageValue - position),
                            child: (position == 0)
                                ? Stack(children: [
                                    Positioned.fill(
                                      child: Container(
                                          color: primaryGreen,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height / 8),
                                              child: Column(children: [
                                                Container(
                                                  child: FlutterLogo(size: 50),
                                                ),
                                                SizedBox(height: 25),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'emailLogin'],
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon: Icon(
                                                                  Icons.email),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  ' Email')),
                                                ),
                                                SizedBox(height: 25),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'passwordLogin'],
                                                      obscureText: true,
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'password')),
                                                ),
                                              ]),
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.58),
                                        child: InkWell(
                                            onTap: () => (!isLoading)
                                                ? loginAct(
                                                    controller['emailLogin']
                                                        .text,
                                                    controller['passwordLogin']
                                                        .text)
                                                : {debugPrint('isloading')},
                                            child: AnimatedContainer(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                padding: EdgeInsets.all(15),
                                                duration:
                                                    Duration(milliseconds: 200),
                                                child: (isLoading)
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Text(
                                                        '      Login        ',
                                                        style: TextStyle(
                                                            color: primaryBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                      ),
                                    ),
                                  ])
                                : Stack(children: [
                                    Positioned.fill(
                                      child: Container(
                                          color: primaryBlue,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height / 8),
                                              child: Column(children: [
                                                Container(
                                                  child: FlutterLogo(
                                                    size: 50,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'fullname'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .perm_identity),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'fullname')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'emailRegister'],
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon: Icon(
                                                                  Icons.email),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Email')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      obscureText: true,
                                                      controller: controller[
                                                          'password'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'password')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      obscureText: true,
                                                      controller: controller[
                                                          'confirmPassword'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'confirm password')),
                                                )
                                              ]),
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.68),
                                        child: InkWell(
                                            onTap: () => (!isLoading)
                                                ? registerAct(
                                                    controller['emailRegister']
                                                        .text,
                                                    controller['password'].text,
                                                    controller['fullname'].text,
                                                    controller[
                                                            'confirmPassword']
                                                        .text)
                                                : {debugPrint('isloading')},
                                            child: AnimatedContainer(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                padding: EdgeInsets.all(15),
                                                duration:
                                                    Duration(milliseconds: 200),
                                                child: (isLoading)
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Text(
                                                        '     Register       ',
                                                        style: TextStyle(
                                                            color: primaryBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                      ),
                                    )
                                  ]));
                                  
                      }else{
                        
                        return Transform(
                            transform: Matrix4.identity()
                              ..rotateZ(currentPageValue - position),
                            child: (position == 0)
                                ? Stack(children: [
                                    Positioned.fill(
                                      child: Container(
                                          color: primaryGreen,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height / 8),
                                              child: Column(children: [
                                                Container(
                                                  child: FlutterLogo(size: 50),
                                                ),
                                                SizedBox(height: 25),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'emailLogin'],
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon: Icon(
                                                                  Icons.email),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  ' Email')),
                                                ),
                                                SizedBox(height: 25),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'passwordLogin'],
                                                      obscureText: true,
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'password')),
                                                ),
                                              ]),
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.58),
                                        child: InkWell(
                                            onTap: () => (!isLoading)
                                                ? loginAct(
                                                    controller['emailLogin']
                                                        .text,
                                                    controller['passwordLogin']
                                                        .text)
                                                : {debugPrint('isloading')},
                                            child: AnimatedContainer(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                padding: EdgeInsets.all(15),
                                                duration:
                                                    Duration(milliseconds: 200),
                                                child: (isLoading)
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Text(
                                                        '      Login        ',
                                                        style: TextStyle(
                                                            color: primaryBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                      ),
                                    ),
                                  ])
                                : Stack(children: [
                                    Positioned.fill(
                                      child: Container(
                                          color: primaryBlue,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height / 8),
                                              child: Column(children: [
                                                Container(
                                                  child: FlutterLogo(
                                                    size: 50,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'fullname'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .perm_identity),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'fullname')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      controller: controller[
                                                          'emailRegister'],
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon: Icon(
                                                                  Icons.email),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Email')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      obscureText: true,
                                                      controller: controller[
                                                          'password'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'password')),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: secondaryBLue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  width: size.width * 0.7,
                                                  child: TextFormField(
                                                      obscureText: true,
                                                      controller: controller[
                                                          'confirmPassword'],
                                                      decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .lock_outline),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'confirm password')),
                                                )
                                              ]),
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.68),
                                        child: InkWell(
                                            onTap: () => (!isLoading)
                                                ? registerAct(
                                                    controller['emailRegister']
                                                        .text,
                                                    controller['password'].text,
                                                    controller['fullname'].text,
                                                    controller[
                                                            'confirmPassword']
                                                        .text)
                                                : {debugPrint('isloading')},
                                            child: AnimatedContainer(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                padding: EdgeInsets.all(15),
                                                duration:
                                                    Duration(milliseconds: 200),
                                                child: (isLoading)
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Text(
                                                        '     Register       ',
                                                        style: TextStyle(
                                                            color: primaryBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                      ),
                                    )
                                  ]));
                                  
                      }
                    },
                  ),
                )),
                AnimatedPositioned(
                    left: (currentPageValue == 0) ? -size.width : 0,
                    top: size.height * 0.8,
                    child: InkWell(
                      onTap: toLoginPage,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 30, top: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                            color: primaryGreen,
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(25))),
                        child: Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                  text: ' Login',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold))
                            ],
                            text: 'OR ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white))),
                      ),
                    ),
                    duration: Duration(
                        milliseconds: (currentPageValue == 0) ? 10 : 500)),
                AnimatedPositioned(
                    right: (currentPageValue == 1) ? -size.width : 0,
                    curve: Curves.bounceInOut,
                    top: size.height * 0.8,
                    child: InkWell(
                      onTap: toRegisterPage,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 30, top: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25))),
                        child: Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                  text: ' Register',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold))
                            ],
                            text: 'OR ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white))),
                      ),
                    ),
                    duration: Duration(
                        milliseconds: (currentPageValue == 1) ? 10 : 500)),
              ])),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: (isSuccessfull)?-size.height:-2,
          right: (isSuccessfull)?-size.width:-2,
                  child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            
            decoration: BoxDecoration(color:Colors.white,shape: BoxShape.circle),
            height: (isSuccessfull)?size.height*3:0,
            width: (isSuccessfull)?size.width*3:0,
            onEnd: ()=>goToDashboard(),
          ),
        )
    ]);
  }

  registerAct(
      String email, String password, String fname, String cpassword) async {
    setState(() {
      isLoading = true;
    });
    if (email.isEmpty || password.isEmpty || fname.isEmpty) {
      sk.currentState.showSnackBar(createSnackBar(' form tidak boleh kosong'));
      setState(() {
        isLoading = false;
      });
    } else if (!emailValidator(email)) {
      sk.currentState.showSnackBar(
          createSnackBar(' Email yang anda masukan tidak valid '));
      setState(() {
        isLoading = false;
      });
    } else if (password != cpassword) {
      sk.currentState.showSnackBar(
          createSnackBar('form confirm password tdak sesuai dengan password'));
      setState(() {
        isLoading = false;
      });
    } else {
      var msg = MessageResponse(message: "Register gagal", result: false);
      try {
        var service = Base();
        msg = await service.executeRegister(email, fname, password);
        if (msg.result) {
          msg.message += ", silahkan login";
          setControllerEmpty();
        }
      } on SocketException catch (e) {
        msg.message += (e.osError.message.contains('Connection timed out'))
            ? ' koneksi terputus'
            : ' ';
        debugPrint(e.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
      setState(() {
        isLoading = false;
      });

      sk.currentState.showSnackBar(createSnackBar(msg.message));
    }
  }

  void toLoginPage() {
    if (!isLoading)
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
  }

  void toRegisterPage() {
    if (!isLoading)
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
  }

  Future<void> loginAct(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    if (email.isEmpty || password.isEmpty) {
      sk.currentState.showSnackBar(
          createSnackBar(' Email dan password tidak boleh kosong'));
      setState(() {
        isLoading = false;
      });
    } else if (!emailValidator(email)) {
      sk.currentState.showSnackBar(
          createSnackBar(' Email yang anda masukan tidak valid '));
      setState(() {
        isLoading = false;
      });
    } else {
      var msg = MessageResponse(message: "login gagal", result: false);
      try {
        var service = Base();
        msg = await service.executeLogin(email, password);
        if (msg.message.contains('gagal'))
          msg.message += ", kredensial yang anda masukan salah";
      } on SocketException catch (e) {
        msg.message += (e.osError.message.contains('Connection timed out'))
            ? ' koneksi terputus'
            : ' ';
        debugPrint(e.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
      setState(() {
        isLoading = false;
      });
      sk.currentState.showSnackBar(createSnackBar(msg.message));
      debugPrint(msg.result.toString());
      if (msg.result) {
        delayMethod(700, () {
          SfService().saveLogin(msg.fnameData, email);
          isSuccessfull = true;
          setState(() {});
        });
        //delayMethod(1000, goToDashboard());
      }
    }
  }

  animate() {
    setState(() {
      isSuccessfull = true;
    });
  }

  goToDashboard() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
  }
}
