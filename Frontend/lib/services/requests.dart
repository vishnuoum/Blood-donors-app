import 'dart:convert';

import 'package:http/http.dart';

class Requests{

  String url="https://blood-donors-kerala.000webhostapp.com/requests.php";
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