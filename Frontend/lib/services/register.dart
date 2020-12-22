

import 'package:http/http.dart';

class Register{
  String name,dob,place,district,phone,bloodGroup,url="<link>/register.php";
  Response response;

  Register({this.name,this.dob,this.place,this.district,this.phone,this.bloodGroup});

  Future<dynamic> beDonor() async{
    try {
      response = await post(url, body: {
        "name": name,
        "bloodGroup": bloodGroup,
        "dob": dob,
        "district": district,
        "place": place,
        "phone": phone
      });

      return response.body;
    }
    catch(error){
      return "error";
    }
  }
}
