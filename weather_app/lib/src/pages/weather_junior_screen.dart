import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart' as intl;
import 'package:location/location.dart';

import 'package:weather_app/src/design/custom_painter.dart';

// ignore: must_be_immutable
class JuniorWeatherScreen extends StatefulWidget {
  String city;
  @override
  State<StatefulWidget> createState() {
    return _JuniorWeatherScreen(city: this.city);
  }

  JuniorWeatherScreen({Key key, @required this.city}) : super(key: key);
}

class _JuniorWeatherScreen extends State<JuniorWeatherScreen> {
  final myController = TextEditingController();
  String city;
  var temp;
  var description;
  var currently;
  var humidity;
  var pressure;
  var windSpeed;
  var sunrise;
  var sunset;
  String time;
  String key;

  // ignore: unused_element
  _JuniorWeatherScreen({Key key, @required this.city}) : super();

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=${this.city}&units=metric&appid=${this.key}'));


    var results = jsonDecode(response.body);
    setState(
      () {
        this.temp = results['main']['temp'];
        this.description = results['weather'][0]['description'];
        this.currently = results['weather'][0]['main'];
        this.humidity = results['main']['humidity'];
        this.pressure = results['main']['pressure'];
        this.sunrise = results['sys']['sunrise'];
        this.sunset = results['sys']['sunset'];
        this.windSpeed = results['wind']['speed'];
        this.time = intl.DateFormat("Hm").format(DateTime.now());
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: CustomPaint(
                foregroundPainter: SunPainter(context),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(
                flex: 8,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      textInputAction: TextInputAction.go,
                      style: Theme.of(context).textTheme.subtitle2,
                      controller: myController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 5.0,
                              style: BorderStyle.solid),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0)),
                        hintText: 'Enter a city name',
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                print("pressed");
                                city = myController.text;
                                getWeather();
                              },
                            );
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  )
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 60,
                    width: 130,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.temperatureHigh),
                            Spacer(),
                            Text(
                              temp != null ? temp.toString() : "...",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 60,
                    width: 130,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 2))
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.compress),
                            Spacer(),
                            Text(
                              pressure != null ? pressure.toString() : "...",
                              style: Theme.of(context).textTheme.headline5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 60,
                    width: 135,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 2))
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.solidSun),
                            Spacer(),
                            Text(
                              sunrise != null
                                  ? intl.DateFormat('Hm')
                                      .format(
                                          DateTime.fromMicrosecondsSinceEpoch(
                                              sunrise * 1000000))
                                      .toString()
                                  : "...",
                              style: Theme.of(context).textTheme.headline5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  Container(
                    height: 60,
                    width: 130,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 2))
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.solidMoon),
                            Spacer(),
                            Text(
                              sunset != null
                                  ? intl.DateFormat('Hm')
                                      .format(
                                          DateTime.fromMicrosecondsSinceEpoch(
                                              sunset * 1000000))
                                      .toString()
                                  : "...",
                              style: Theme.of(context).textTheme.headline5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 60,
                    width: 180,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.calendar),
                            Spacer(),
                            Text(
                              intl.DateFormat('y-M-d').format(DateTime.now()),
                              style: Theme.of(context).textTheme.headline5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    height: 60,
                    width: 130,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 2))
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.solidClock),
                            Spacer(),
                            Text(
                              time != null ? time : "...",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
              Spacer(
                flex: 8,
              )
            ],
          )
        ],
      ),
    );
  }
}
