import 'package:blood_donors/services/sendOtp.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class OTP extends StatefulWidget {

  final Map args;
  OTP(this.args);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  int timerCount=60;
  SendOtp sendOtp;
  dynamic response;
  bool verify=false,stop=false;


  @override
  void initState() {
    super.initState();


    sendOtp=SendOtp(phone: widget.args["phone"]);
    send();


  }

  void send() async{
    countDownTimer();
    response = await sendOtp.send();
    if(response!="ok"){
      print(response);
      showAlertDialog(context, "Something went wrong. Please try again");
    }
  }

  void countDownTimer() async {
    for (int x = 59; x > -1; x--) {
      if(stop) break;
      await Future.delayed(Duration(seconds: 1)).then((_) {
        if(mounted) setState(() {
          timerCount = x;
        });
        print(timerCount);
      });
    }
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
  showProgressDialog(BuildContext context,String msg) {


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: SizedBox(height: 100,width: 150,child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 6,)),SizedBox(height: 20,),Text(msg,style: TextStyle(fontSize: 18),)]))),
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

  showSpecialAlertDialog(BuildContext context,String msg) {

    // set up the buttons
//    Widget cancelButton = FlatButton(
//      child: Text("Cancel"),
//      onPressed:  () {},
//    );
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        stop=true;
        Navigator.pop(context);
        Navigator.pop(context);
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
        return WillPopScope(
            onWillPop: () async => false,
            child: alert
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Verify Mobile Number",style: TextStyle(color: Colors.black),),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:30.0),
              child: Text("Enter OTP",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            PinEntryTextField(
              fields: 6,
            onSubmit: (String pin){
                if(pin==sendOtp.otp){
                  setState(() {
                    verify=true;
                  });
                }
                else{
                  showAlertDialog(context, "You entered wrong OTP");
                }
            }, // end onSubmit
          ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Row(
                children: [
                  Expanded(
                      child: FlatButton(
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        textColor: Colors.white,
                        color: Color(0xffde0a1e),
                        child: Text(timerCount==0?"Resend OTP":"Resend in ${timerCount.toString()}"),
                        onPressed: timerCount==0?countDownTimer:send,
                      )
                  ),
                  SizedBox(width:10 ,),
                  Expanded(
                      child: FlatButton(
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        textColor: Colors.white,
                        color: Color(0xffde0a1e),
                        child: Text("Verify"),
                        onPressed: !verify?null:() async{


                          if(widget.args["type"]=="donor"){
                            showProgressDialog(context,"Registering");
                            response=await widget.args["object"].beDonor();
                            if(response=="Done"){
                              Navigator.pop(context);
                              showSpecialAlertDialog(context, "Successfully Registered");
                            }
                            else{
                              Navigator.pop(context);
                              showAlertDialog(context, "Something went wrong");
                            }
                          }


                          else if(widget.args["type"]=="request"){
                            showProgressDialog(context,"Registering request");
                            if(await widget.args["object"].registerRequest()=="Done"){
                              Navigator.pop(context);
                              showSpecialAlertDialog(context, "Request Registered Successfully");
                            }
                            else{
                              Navigator.pop(context);
                              showAlertDialog(context, "Something went wrong");
                            }
                          }


                        },
                      )
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
