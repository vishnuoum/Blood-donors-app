import 'dart:convert';

import 'package:http/http.dart';

class Requests{

  String url="<link>/requests.php";
  Response response;

  Future<dynamic> getRequests() async{
    try {
      response = await get(url);
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
    catch(error){
      print(error);
      return "error";
    }
  }

}
