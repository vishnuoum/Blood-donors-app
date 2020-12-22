

import 'dart:convert';

import 'package:http/http.dart';

class RequestUnit{

  String patient,date,time,hospital,district,units,bystander,phone,bloodGroup,url="<link>/request.php";

  RequestUnit({this.patient,this.date,this.time,this.hospital,this.district,this.units,this.bystander,this.phone,this.bloodGroup});
  Response response;

  Future<dynamic> registerRequest() async{
    try {
      response = await post(url, body: {
        "patient": patient,
        "date": date,
        "time": time,
        "hospital": hospital,
        "district": district,
        "units": units,
        "bystander": bystander,
        "contact": phone,
        "blood": bloodGroup
      });

      return (response.body);
    }
    catch(error){
      print(error);
      return "error";
    }
  }

}
