import 'package:shared_preferences/shared_preferences.dart';

 class SfService {
    getLoginStat()async{
      SharedPreferences sf =await SharedPreferences.getInstance();
        return sf.getBool("isLogin")??false;
    }
    saveLogin(String fname,String email)async{
       SharedPreferences sf =await SharedPreferences.getInstance();
       sf.setBool('isLogin', true);
       sf.setString('name', fname);
       sf.setString('email', email);
    }
    sfLogout()async{
       SharedPreferences sf =await SharedPreferences.getInstance();
        sf.setBool('isLogin', false);
       sf.setString('name', '');
       sf.setString('email', '');
    }
   Future<Map<String,dynamic>> getSavedlogin()async{
        if(await getLoginStat()){
          
       SharedPreferences sf =await SharedPreferences.getInstance();
         String nama= sf.getString('name');
         String email= sf.getString('email');
         return {
           'nama':nama,
           'email':email
         };

       }
    }
}