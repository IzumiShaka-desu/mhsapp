import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mhsapp/const.dart';

emailValidator(String email){
    if(email.contains('@')){
      if(email.split('@')[1].contains('.')){
        return true;
      }
    }
    return false;
}
Future delayMethod(int delayMillis,Function method)async{
      return Timer(Duration(milliseconds: delayMillis),method);
}

createSnackBar(String msg)=>SnackBar(content: Container(height:30,child:Center(child:Text(msg)),),backgroundColor: secondaryBLue.withOpacity(0.9),);