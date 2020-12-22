import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro>  with SingleTickerProviderStateMixin{
  
  TabController tabController;
  SharedPreferences pref;
  
  @override
  initState(){
    super.initState();
    tabController=TabController(length: 2, vsync: this);
    tabController.addListener((){
      setState(() {
        index=tabController.index;
      });
    });

    initialize();
  }

  void initialize() async{
    pref=await SharedPreferences.getInstance();
    pref.setString("intro", "yes");
  }

  int index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            TabBarView(
              controller: tabController,
                children: [
                  Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 180,child: Image.asset("assets/icon.png")),Text("Donate Blood",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)],),),
                  Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 180,child: Image.asset("assets/icon.png")),Text("Request Blood",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)],),),
                ]
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: index==0?Color(0xffde0a1e):Colors.grey,
                    ),
                    SizedBox(width: 5,),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: index==1?Color(0xffde0a1e):Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,left: 0,
                child: GestureDetector(
                  onTap: index==1?null:(){
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Skip",style: TextStyle(color: index==1?Colors.grey:Color(0xffde0a1e),fontWeight: FontWeight.bold),),
                  ),
                )
            ),
            Positioned(
                bottom: 0,left: 0,
                child: GestureDetector(
                  onTap: index==0?null:(){
                    setState(() {
                      index--;
                    });
                    tabController.animateTo(0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Prev",style: TextStyle(color: index==0?Colors.grey:Color(0xffde0a1e),fontWeight: FontWeight.bold),),
                  ),
                )
            ),
            Positioned(
                bottom: 0,right: 0,
                child: GestureDetector(
                  onTap: (){
                    if(index==0) {
                      setState(() {
                        index++;
                      });
                      tabController.animateTo(1);
                    }
                    else{
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(index==0?"Next":"Continue",style: TextStyle(color: Color(0xffde0a1e),fontWeight: FontWeight.bold),),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
