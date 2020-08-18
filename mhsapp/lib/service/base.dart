import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mhsapp/models/message.dart';

class Base {
  var client = http.Client();
  static const host = "http://192.168.43.150/";
  
  static const pathLogin = "mhs/webservice/servicelogin.php";
  static const pathRegister = "mhs/webservice/serviceregister.php";
  Future<MessageResponse> executeLogin(
      String email, String password) async {
          var response=await client.post(host+pathLogin,body:{
            'email':email,
            'password':password
          });
          if(response.statusCode==200){
           return MessageResponse.fromJson(jsonDecode(response.body));
          }
          return MessageResponse();
      }

Future<MessageResponse> executeRegister(
      String email,String fullname, String password) async {
          var response=await client.post(host+pathRegister,body:{
            'email':email,
            'fname':fullname,
            'password':password
          });
          if(response.statusCode==200){
           return MessageResponse.fromJson(jsonDecode(response.body));
          }
          return MessageResponse();
      }
}
