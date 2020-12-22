import 'package:blood_donors/services/register.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class Donors extends StatefulWidget {
  @override
  _DonorsState createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {

  String bloodGroup='O+',dropdownValue='Select Gender',district='Select District',response;
  DateTime newDateTime;

  Register register;


  TextEditingController name,gender,weight,number,place;
  String dob='Date Of Birth';
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    place=TextEditingController();
    name=TextEditingController();
    gender=TextEditingController();
    weight=TextEditingController();
    number=TextEditingController();
  }

  showAlertDialog(BuildContext context,String msg) {

    // set up the buttons
//    Widget cancelButton = FlatButton(
//      child: Text("Cancel"),
//      onPressed:  () {},
//    );
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(msg),
      actions: [
//        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showProgressDialog(BuildContext context) {


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: SizedBox(height: 100,width: 150,child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 6,)),SizedBox(height: 20,),Text("Registering",style: TextStyle(fontSize: 18),)]))),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
            child: alert
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('tapped');
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Be A Donor',style: TextStyle(color: Colors.black,fontSize: 17),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal:30,vertical: 20),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    focusNode: null,
                    style: TextStyle(color: Colors.black),
                    controller: name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full name'
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async{
                    FocusScope.of(context).unfocus();
                    newDateTime = await showRoundedDatePicker(
                      theme: ThemeData(
                          primarySwatch:Colors.red,
                          accentColor: Color(0xffde0a1e),
                          backgroundColor: Colors.white,
                          primaryColor: Color(0xffde0a1e),
                          hoverColor: Colors.white
                      ),
                      context: context,
                      height: 280,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(DateTime.now().year+1),
                      borderRadius: 16,
                    );
                    setState(() {
                      dob=newDateTime==null?dob:formatDate(newDateTime, [dd, '/', mm, '/', yyyy ]);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    child: Text(dob,style: TextStyle(color: dob=='Date Of Birth'?Colors.grey[700]:Colors.black,fontSize: 15),),
                  ),
                ),
//                SizedBox(height: 10,),
//                Container(
//                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.grey[200]
//                  ),
//                  child: Row(
//                    children: [Expanded(
//                      child: DropdownButton<String>(
//                        value: dropdownValue,
//                        icon: Icon(Icons.arrow_downward,color: Colors.transparent),
//                        iconSize: 24,
//                        elevation: 16,
//                        underline: Container(),
//                        style: TextStyle(color: dropdownValue=='Select Gender'?Colors.grey[700]:Colors.black,fontSize: 16,),
//                        onChanged: (String newValue) {
//                          setState(() {
//                            dropdownValue = newValue;
//                          });
//                        },
//                        items: <String>['Select Gender', 'Male', 'Female', 'Other']
//                            .map<DropdownMenuItem<String>>((String value) {
//                          return DropdownMenuItem<String>(
//                            value: value,
//                            child: Text(value,style: TextStyle(color: value=='Select Gender'?Colors.grey[700]:Colors.black),),
//                          );
//                        }).toList(),
//                      ),
//                    ),
//                      Icon(Icons.keyboard_arrow_down,color: Colors.grey[700],)
//                    ],
//                  ),
//                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    focusNode: null,
                    style: TextStyle(color: Colors.black),
                    controller: place,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Place name'
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]
                  ),
                  child: Row(
                    children: [Expanded(
                      child: DropdownButton<String>(
                        value: district,
                        icon: Icon(Icons.arrow_downward,color: Colors.transparent),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(),
                        style: TextStyle(color: district=='Select District'?Colors.grey[700]:Colors.black,fontSize: 16,),
                        onChanged: (String newValue) {
                          setState(() {
                            district = newValue;
                          });
                        },
                        items: <String>['Select District', 'Kasargod', 'Kannur', 'Wayanad','Palakkad','Kozhikode','Malappuram','Thrissur','Ernakulam','Idukki','Alappuzha','Kottayam','Kollam','Pathanamthitta','Thiruvananthapuram']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(color: value=='Select District'?Colors.grey[700]:Colors.black),),
                          );
                        }).toList(),
                      ),
                    ),
                      Icon(Icons.keyboard_arrow_down,color: Colors.grey[700],)
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: weight,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Body Weight ( in KG )'
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: number,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Contact Number'
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(bottom: 20,left: 10,top: 10),
                  child: Text('Select Blood Group',style: TextStyle(fontWeight: FontWeight.bold,),),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                          color: bloodGroup=='O+'?Color(0xffde0a1e):Colors.white,
                          textColor: bloodGroup=='O+'?Colors.white:Color(0xffde0a1e),
                          height: 50,
                          shape: CircleBorder(),
                          onPressed: (){
                            setState(() {
                              bloodGroup='O+';
                            });
                          },
                          child: Text('O+',style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        color: bloodGroup=='A+'?Color(0xffde0a1e):Colors.white,
                        textColor: bloodGroup=='A+'?Colors.white:Color(0xffde0a1e),
                        height: 50,
                        shape: CircleBorder(),
                        onPressed: (){
                          setState(() {
                            bloodGroup='A+';
                          });
                        },
                        child: Text('A+',style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        color: bloodGroup=='B+'?Color(0xffde0a1e):Colors.white,
                        textColor: bloodGroup=='B+'?Colors.white:Color(0xffde0a1e),
                        height: 50,
                        shape: CircleBorder(),
                        onPressed: (){
                          setState(() {
                            bloodGroup='B+';
                          });
                        },
                        child: Text('B+',style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        color: bloodGroup=='AB+'?Color(0xffde0a1e):Colors.white,
                        textColor: bloodGroup=='AB+'?Colors.white:Color(0xffde0a1e),
                        height: 50,
                        shape: CircleBorder(),
                        onPressed: (){
                          setState(() {
                            bloodGroup='AB+';
                          });
                        },
                        child: Text('AB+',style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                          color: bloodGroup=='O-'?Color(0xffde0a1e):Colors.white,
                          textColor: bloodGroup=='O-'?Colors.white:Color(0xffde0a1e),
                          height: 50,
                          shape: CircleBorder(),
                          onPressed: (){
                            setState(() {
                              bloodGroup='O-';
                            });
                          },
                          child: Text('O-',style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                          color: bloodGroup=='A-'?Color(0xffde0a1e):Colors.white,
                          textColor: bloodGroup=='A-'?Colors.white:Color(0xffde0a1e),
                          height: 50,
                          shape: CircleBorder(),
                          onPressed: (){
                            setState(() {
                              bloodGroup='A-';
                            });
                          },
                          child: Text('A-',style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                          color: bloodGroup=='B-'?Color(0xffde0a1e):Colors.white,
                          textColor: bloodGroup=='B-'?Colors.white:Color(0xffde0a1e),
                          height: 50,
                          shape: CircleBorder(),
                          onPressed: (){
                            setState(() {
                              bloodGroup='B-';
                            });
                          },
                          child: Text('B-',style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                          color: bloodGroup=='AB-'?Color(0xffde0a1e):Colors.white,
                          textColor: bloodGroup=='AB-'?Colors.white:Color(0xffde0a1e),
                          height: 50,
                          shape: CircleBorder(),
                          onPressed: (){
                            setState(() {
                              bloodGroup='AB-';
                            });
                          },
                          child: Text('AB-',style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Container(
                  margin: EdgeInsets.only(right: 150),
                  width: 20,
                  child: FlatButton(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    color: Color(0xffde0a1e),
                    textColor: Colors.white,
                    child: Text('Submit',style: TextStyle(fontSize: 16),),
                    onPressed: () async{

                      FocusScope.of(context).unfocus();
                      if(name.text=='' || dob=='Date Of Birth' || place.text=='' || district=="Select District" || weight.text=='' || number.text==''){
                        showAlertDialog(context, "Please enter all fields");
                      }
                      else if(DateTime.now().year-newDateTime.year<18){
                        showAlertDialog(context, "You must be at least 18 years old to donate blood");
                      }
                      else if(int.parse(weight.text)<50){
                        showAlertDialog(context, "You are not fit to donate blood");
                      }
                      else {
//                        showProgressDialog(context);
                        register=Register(district: district,bloodGroup: bloodGroup,phone: number.text,name: name.text,dob: dob,place: place.text);
                        Navigator.pushNamed(context, "/otp",arguments: {"phone":number.text,"object":register,"type":"donor"});
//                        response=await register.beDonor();
//                        if(response=="Done"){
//                          Navigator.pop(context);
//                          showAlertDialog(context, "Successfully Registered");
//                        }
//                        else{
//                          Navigator.pop(context);
//                          showAlertDialog(context, "Something went wrong");
//                        }
                      }

                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
