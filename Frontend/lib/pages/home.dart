import 'package:blood_donors/services/requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blood_donors/icons/my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String bloodGroup='Select Blood Group',district='Select District',msg='Loading';
  dynamic result=[],response;
  bool loading=true,hidden=false;
  ScrollController scrollController;


  @override
  void initState() {
    super.initState();

    getRequests();
    scrollController=ScrollController();

  }

  void getRequests() async {
    response=await Requests().getRequests();
    setState(() {
      result=response!='error'?response:result;
      msg=response!='error'?'Loading':'Something Went Wrong';
      loading=response=='error';
    });

    if(response=='error'){
      Future.delayed(Duration(seconds: 5),(){
        getRequests();
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




  Widget stack(BuildContext context){
    return Stack(
    children: [Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
//                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            color: Color(0xffde0a1e),
          ),
        )
    ),
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Find a Donor',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.grey[200]
                ),
                child: Row(
                  children: [
                    Expanded(child: DropdownButton(
                      value:district,
                      items: ['Select District','Thrissur','Kasargod','Kannur','Palakkad','Wayanad','Malappuram','Kozhikode','Ernakulam','Idukki','Alappuzha','Kottayam','Kollam','Pathanamthitta','Thiruvananthapuram'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                            style: TextStyle(color: value=='Select District'?Colors.grey:Colors.black),
                          ),
                        );
                      }).toList(),
                      icon: null,
                      underline: Container(),
                      iconSize: 0,
                      onChanged: (String newValue) {
                        setState(() {
                          district = newValue;
                        });
                      },
                    )),
                    SizedBox(width: 20,),
                    Icon(Icons.location_on)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.grey[200]
                ),
                child: Row(
                  children: [
                    Expanded(child: DropdownButton(
                      value:bloodGroup,
                      items: ['Select Blood Group','O +ve','O -ve','A +ve','A -ve','B +ve','B -ve','AB +ve','AB -ve'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                            style: TextStyle(color: value=='Select Blood Group'?Colors.grey[500]:Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text('Select blood group'),
                      icon: null,
                      underline: Container(),
                      iconSize: 0,
                      onChanged: (String newValue) {
                        setState(() {
                          bloodGroup = newValue;
                        });
                      },
                    )),
                    SizedBox(width: 20,),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              SizedBox(height: 10,)
              ,                      FlatButton(
                padding: EdgeInsets.symmetric(vertical:17,horizontal: 40),
                onPressed: () async{
                  if(bloodGroup=="Select Blood Group" || district=="Select District"){
                    showAlertDialog(context, "Please select valid options!!");
                  }
                  else{
                    await Navigator.pushNamed(context, '/explore',arguments: {"district":district,"bloodGroup":bloodGroup}).then((value) => setState(() {
                      loading=true;
                      district="Select District";
                      bloodGroup="Select Blood Group";
                    }));

                    getRequests();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                textColor: Colors.white,
                child: Text('Search',style: TextStyle(fontSize: 16),),
                color: Color(0xffde0a1e),
              )
            ],
          ),
        ),
      ),
    ],
  );
  }

  Widget recentTitle(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left:20.0,top: 5,bottom: 5),
      child: Text("Recent Requests",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
    );
  }

  Widget completelist(BuildContext context,dynamic data){
    return Padding(
      padding: EdgeInsets.only(left:10,right: 10,top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 0,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
          onTap: (){},
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffee848e),
            ),
            child: Center(child: Text(data['bgroup'],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),
            height: 60,
            width: 60,
          ),
          title: Text('${data["pname"]} - ${data["units"]} Unit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${data["hospital"]} - ${data["district"]}',overflow: TextOverflow.ellipsis,),
              Text('${data["time"]} ${data["date"]}, ${data["bname"]}',overflow: TextOverflow.ellipsis,)
            ],
          ),
          trailing: IconButton(icon: Icon(Icons.call,color: Color(0xffde0a1e),),onPressed: (){
            var url="tel:${data["bphone"]}";
            if(canLaunch(url) != null){
              launch(url);
            }
            else{
              print("cannot launch");
            }
          },),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donors',),
        centerTitle: true,
        backgroundColor: Color(0xffde0a1e),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffde0a1e)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height:80,
                    width: 80,
                    decoration:BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                  ),
                    child: SizedBox(
                      child: Image.asset('assets/icon.png'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Blood Donors',style: TextStyle(fontSize: 20,color: (Colors.white)),),
                ],
              ),
            ),
            ListTile(
              leading: Icon(MyFlutterApp.water_drop,color: Color(0xffde0a1e),),
              title: Text('Be A Donor',style: TextStyle(color: Color(0xffde0a1e))),
              onTap: () async{

                Navigator.pop(context);
                await Navigator.pushNamed(context, '/donors').then((value) => setState(() {
                  loading=true;
                  district="Select District";
                  bloodGroup="Select Blood Group";
                })
                );

                getRequests();

              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline,color: Color(0xffde0a1e),),
              title: Text('About Us',style: TextStyle(color: Color(0xffde0a1e)),),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.call,color: Color(0xffde0a1e),),
              title: Text('Contact Us',style: TextStyle(color: Color(0xffde0a1e)),),
              onTap: (){},
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: !loading?NotificationListener(
          onNotification: (notification){
              if(notification is ScrollEndNotification || notification is ScrollStartNotification){
                print(scrollController.position.pixels);
                setState(() {
                  hidden=scrollController.position.pixels>0;
                });
              }
              return;
          },
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(bottom: 20),
            itemCount: result.length+2+(result.length==0?1:0),
            itemBuilder: (BuildContext context, int index) {
              return index==0?stack(context):index==1?recentTitle(context):(result.length==0 && index==2)?Container(margin: EdgeInsets.only(top: 80),child: Text("No requests found",style: TextStyle(color: Colors.grey,fontSize: 17),textAlign: TextAlign.center,)):completelist(context,result[index-2]);
            },
          ),
        ):Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 6,)),SizedBox(height: 20,),Text(msg)],)),
      ),
      floatingActionButton: !loading?!hidden?FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xffde0a1e),width: 3),
          borderRadius: BorderRadius.circular(100)
        ),
        onPressed: () async{
          await Navigator.pushNamed(context, '/request').then((value) => setState(() {
            loading=true;
            district="Select District";
            bloodGroup="Select Blood Group";
          })
          );

          getRequests();
        },
        child: Icon(MyFlutterApp.water_drop,color: Color(0xffde0a1e),),
      ):null:null,
    );
  }
}
