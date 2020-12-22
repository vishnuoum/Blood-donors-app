

import 'dart:math';

import 'package:http/http.dart';

class SendOtp{
  String phone,otp= (Random().nextInt(900000) + 100000).toString(),url="https://blood-donors-kerala.000webhostapp.com/otp.php";
  Response response;

  SendOtp({this.phone});

  Future<dynamic> send() async{
    try {
      response = await post(url,body: {"phone":phone,"otp":otp});
      print(response.body);
      return response.body.toString();
    }
    catch(error){
      return "error";
    }
  }

}