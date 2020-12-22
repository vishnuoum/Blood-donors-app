import 'package:blood_donors/services/search.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Explore extends StatefulWidget {

  final Map args;
  Explore(this.args);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  Search search;
  String msg="Loading";
  dynamic result=[],response;
  bool loading=true;

  @override
  void initState() {
    super.initState();

    getResult(widget.args);
  }

  void getResult(Map data) async{
    data["bloodGroup"]=data["bloodGroup"].replaceAll(" -ve","-");
    data["bloodGroup"]=data["bloodGroup"].replaceAll(" +ve","+");
    print(data);

    search=Search(bloodGroup: data["bloodGroup"],district: data["district"]);
    response=await search.getResult();

    setState(() {
      msg=response!="error"?"Loading":"Something Went Wrong";
      result=response!="error"?response:result;
      loading=response=="error";
    });

    if(response=="error"){
      Future.delayed(Duration(seconds: 5),(){
        getResult(data);
      });
    }

  }


  Widget list(BuildContext context,Map data){
    return Padding(
      padding: EdgeInsets.only(left:10,right: 10,top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 0,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
          onTap: (){},
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffee848e),
            ),
            child: Center(child: Text(data["bgroup"],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),
            height: 60,
            width: 60,
          ),
          title: Text(data["name"],style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text('${data["place"]}-${data["district"]}',
//                    style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            onPressed: () async {
              var url = "tel:${data["phone"]}";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                print('Could not launch $url');
              }
            },
            icon: Icon(Icons.call),
            color: Color(0xffde0a01),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Explore Donors',style: TextStyle(color: Colors.black,fontSize: 17),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: loading?Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 6,)),SizedBox(height: 20,),Text(msg)],),):Container(
        color: Colors.white,
        child: result.length==0?Center(child: Text("No results found",style: TextStyle(color: Colors.grey,fontSize: 17),),):ListView.builder(
          itemCount: result.length,
            itemBuilder: (BuildContext context,int index){
              return list(context, result[index]);
            }
        ),
      ),
    );
  }
}
