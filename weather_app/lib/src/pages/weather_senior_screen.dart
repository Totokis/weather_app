import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/src/design/custom_painter.dart';
import 'dart:convert';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class Home extends StatefulWidget {
  final String city;
  @override
  State<StatefulWidget> createState() {
    return _HomeState(city: this.city);
  }

  Home({Key key, @required this.city}) : super(key: key);
}

class _HomeState extends State<Home> {
  final String city;
  var temp;
  var description;
  var currently;
  var humidity;
  var pressure;
  var windSpeed;
  var sunrise;
  var sunset;
  String time;

  // ignore: unused_element
  _HomeState({Key key, @required this.city}) : super();

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=${this.city}&units=metric&appid=6eaf6eabfe094419b971940e92661b61'));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.pressure = results['main']['pressure'];
      this.sunrise = results['sys']['sunrise'];
      this.sunset = results['sys']['sunset'];
      this.windSpeed = results['wind']['speed'];
      this.time = intl.DateFormat("Hm").format(DateTime.now());
    });
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
          Row(
            children: [
              Spacer(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 3,
                    ),
                    Container(
                      height: 80,
                      width: 160,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
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
                          Text(
                            "TEMPERATURE",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.temperatureHigh),
                              Spacer(),
                              Text(
                                temp != null ? temp.toString() : "...",
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 80,
                      width: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
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
                          Text(
                            "PRESSURE",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.compress),
                              Spacer(),
                              Text(
                                pressure != null ? pressure.toString() : "...",
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 80,
                      width: 155,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
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
                          Text(
                            "SUNRISE",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.sun),
                              Spacer(),
                              Text(
                                sunrise != null
                                    ? intl.DateFormat('Hm')
                                        .format(
                                            DateTime.fromMicrosecondsSinceEpoch(
                                                sunrise * 1000000))
                                        .toString()
                                    : "...",
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 80,
                      width: 155,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
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
                          Text(
                            "SUNSET",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.moon),
                              Spacer(),
                              Text(
                                sunset != null
                                    ? intl.DateFormat('Hm')
                                        .format(
                                            DateTime.fromMicrosecondsSinceEpoch(
                                                sunset * 1000000))
                                        .toString()
                                    : "...",
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 80,
                      width: 230,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
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
                          Text(
                            "TODAY IS: ",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.calendar),
                              Spacer(),
                              Text(
                                intl.DateFormat('y-M-d').format(DateTime.now()),
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ]),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    ),
                    Container(
                      height: 80,
                      width: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    ),
                    Container(
                      height: 80,
                      width: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    ),
                    Container(
                      height: 200,
                      width: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
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
                          Text(
                            time != null ? time : "...",
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                  ]),
              Spacer()
            ],
          ),
        ],
      ),
    );
  }
}
