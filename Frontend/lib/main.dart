import 'package:blood_donors/pages/donor.dart';
import 'package:blood_donors/pages/explore.dart';
import 'package:blood_donors/pages/home.dart';
import 'package:blood_donors/pages/intro.dart';
import 'package:blood_donors/pages/otp.dart';
import 'package:blood_donors/pages/request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences pref;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  pref=await SharedPreferences.getInstance();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {


  Map<int, Color> color = {
    50: Color.fromRGBO(222 , 10, 30, .1),
    100: Color.fromRGBO(222 , 10, 30, .2),
    200: Color.fromRGBO(222 , 10, 30, .3),
    300: Color.fromRGBO(222 , 10, 30, .4),
    400: Color.fromRGBO(222 , 10, 30, .5),
    500: Color.fromRGBO(222 , 10, 30, .6),
    600: Color.fromRGBO(222 , 10, 30, .7),
    700: Color.fromRGBO(222 , 10, 30, .8),
    800: Color.fromRGBO(222 , 10, 30, .9),
    900: Color.fromRGBO(222 , 10, 30, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        const Locale('en', 'IN'), // India
      ],
      theme: ThemeData(
          primarySwatch:MaterialColor(0xffde0a1e,color),
        accentColor: Color(0xffde0a1e),
        textSelectionColor: Color.fromRGBO(222, 10, 30, 0.3),
        cursorColor: Color(0xffde0a1e),
        textSelectionHandleColor: Color(0xffde0a1e)
      ),
      debugShowCheckedModeBanner: false,
//      routes: {
//        '/' : (context) => Home(),
//        '/explore' : (context) => Explore(),
//        '/donors' : (context) => Donors(),
//        '/request' : (context) => Request()
//      },
      onGenerateRoute: (RouteSettings settings){
        var routes = <String, WidgetBuilder>{
          '/' : (context) => Home(),
          "/explore": (context) => Explore(settings.arguments),
          '/donors' : (context) => Donors(),
          '/request' : (context) => Request(),
          '/otp' : (context) => OTP(settings.arguments),
          '/intro' : (context) => Intro()
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => builder(context));
      },
      initialRoute: pref.containsKey("intro")?'/':'/intro',
    );
  }
}


