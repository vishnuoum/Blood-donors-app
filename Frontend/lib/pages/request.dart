import 'package:blood_donors/services/request.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController patient,hospital,bystander,bystanderContact,units,reason;
  String date="Choose Date",bloodGroup="O+",district='Select District',time="Choose Time",response;
  DateTime newDateTime;
  TimeOfDay newTime;

  RequestUnit requestUnit;

  @override
  void initState() {
    super.initState();
    reason=TextEditingController();
    patient=TextEditingController();
    units=TextEditingController();
    hospital=TextEditingController();
    bystander=TextEditingController();
    bystanderContact=TextEditingController();
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
      content: SizedBox(height: 100,width: 150,child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 6,)),SizedBox(height: 20,),Text("Registering request",style: TextStyle(fontSize: 18),)]))),
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

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
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
          title: Text('Request',style: TextStyle(color: Colors.black,fontSize: 17),),
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
                    controller: patient,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Patient Name'
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
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year+2),
                      borderRadius: 16,
                    );
                    setState(() {
                      date=newDateTime==null?date:formatDate(newDateTime, [dd, '/', mm, '/', yyyy ]);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    child: Text(date,style: TextStyle(color: date=='Choose Date'?Colors.grey[700]:Colors.black,fontSize: 15),),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async{
                    FocusScope.of(context).unfocus();
                    newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      time=newTime==null?time:newTime.format(context);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    child: Text(time,style: TextStyle(color: time=='Choose Time'?Colors.grey[700]:Colors.black,fontSize: 15),),
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
                    textCapitalization: TextCapitalization.sentences,
                    focusNode: null,
                    style: TextStyle(color: Colors.black),
                    controller: hospital,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Hospital'
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
                    controller: units,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'No. of units'
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
                    textCapitalization: TextCapitalization.sentences,
                    focusNode: null,
                    style: TextStyle(color: Colors.black),
                    controller: bystander,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Bystander Name'
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
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.black),
                    controller: bystanderContact,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Bystander Contact Number'
                    ),
                  ),
                ),
//                SizedBox(height: 10,),
//                Container(
//                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.grey[200]
//                  ),
//                  child: TextField(
//                    textCapitalization: TextCapitalization.sentences,
//                    focusNode: null,
//                    style: TextStyle(color: Colors.black),
//                    controller: reason,
//                    decoration: InputDecoration(
//                        border: InputBorder.none,
//                        hintText: 'Reason...'
//                    ),
//                  ),
//                ),
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

                      if(patient.text=='' || date=="Choose Date" || time=="Choose Time" || hospital.text=='' || district=="Select District" || units.text=='' || bystander.text=='' || bystanderContact.text==''){
                        showAlertDialog(context, "Please fill all the fields");
                      }
                      else if(newDateTime.isBefore(DateTime.now())){
                        showAlertDialog(context, "Please enter valid date");
                      }
                      else if(!isNumeric(bystanderContact.text) || bystanderContact.text.length!=10){
                        showAlertDialog(context, "Please enter valid contact number");
                      }
                      else{

//                        showProgressDialog(context);

                        requestUnit=RequestUnit(
                          phone: bystanderContact.text,
                          bloodGroup: bloodGroup,
                          district: district,
                          bystander: bystander.text,
                          date: date,
                          time: time,
                          hospital: hospital.text,
                          patient: patient.text,
                          units: units.text
                        );
                        await Navigator.pushNamed(context, "/otp",arguments: {"phone":bystanderContact.text,"object":requestUnit,"type":"request"});

//                        if(await requestUnit.registerRequest()=="Done"){
//                          Navigator.pop(context);
//                          showAlertDialog(context, "Request Registered Successfully");
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
