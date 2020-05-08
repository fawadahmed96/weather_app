//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
//// boilerplate code
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter',
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Flutter'),
//        ),
//        body: MyWidget(),
//      ),
//    );
//  }
//}
//
//// widget class
//class MyWidget extends StatefulWidget {
//  @override
//  _MyWidgetState createState() => _MyWidgetState();
//}
//
//// state class
//// We will replace this class in each of the examples below
//class _MyWidgetState extends State<MyWidget> {
//  // state variable
//  String _textString = 'Hello world';
//
//  // The State class must include this method, which builds the widget
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: [
//        Text(
//          _textString,
//          style: TextStyle(fontSize: 30),
//        ),
//        RaisedButton(
//          //                         <--- Button
//          child: Text('Button'),
//          onPressed: () {
//            _doSomething();
//          },
//        ),
//      ],
//    );
//  }
//
//  // this private method is run whenever the button is pressed
//  void _doSomething() {
//    // Using the callback State.setState() is the only way to get the build
//    // method to rerun with the updated state value.
//    setState(() {
//      _textString = 'Hello Flutter';
//    });
//  }
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: "Weather App",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  String show = "";
  void getMessage() {
    setState(() {
      if (temp > 25) {
        show = 'It\'s 🍦 time';
      } else if (temp > 20) {
        show = 'It\'s 🍦 time';
      } else if (temp < 10) {
        show = 'It\'s 🍦 time';
      } else {
        show = 'It\'s 🍦 time';
      }
    });
  }

  Future<void> getWeather() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=city&units=metric&appid={api}');
    var results = jsonDecode(response.body);
    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      currently = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
    getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      temp != null ? temp.toString() + "\u00B0" : "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600),
                    ),
                    FlatButton(
                      child: Text(show),
                      onPressed: () {
                        getMessage();
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.thermometerHalf,
                    ),
                    title: Text(
                      "Temperature",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      temp != null ? temp.toString() + "\u00B0" : "Loading",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.cloud,
                    ),
                    title: Text(
                      "Weather",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      description != null ? description.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.sun,
                    ),
                    title: Text(
                      "Humidity",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      humidity != null ? humidity.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.wind,
                    ),
                    title: Text(
                      "Wind Speed",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      windSpeed != null ? windSpeed.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
