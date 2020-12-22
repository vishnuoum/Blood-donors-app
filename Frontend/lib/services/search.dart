

import 'dart:convert';

import 'package:http/http.dart';

class Search{
  String district,bloodGroup,url="<link>/search.php";
  Response response;


  Search({this.district,this.bloodGroup});

  Future<dynamic> getResult() async{
    try {
      response = await post(url, body: {"district": district, "bloodGroup": bloodGroup});
      print(response.body);
      return jsonDecode(response.body);
    }
    catch(error){
      return "error";
    }
  }

}
