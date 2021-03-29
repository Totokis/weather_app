import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/src/design/custom_painter.dart';
import 'package:weather_app/src/pages/weather_senior_screen.dart';

///Widget ekranu słuązcego do wyszukiwania miasta.
///pole [myController] słuzy do przechowywania wartosci wpisanej
class WeatherSearchPage extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather Search ",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            if ((myController.text.isNotEmpty)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Home(city: myController.text),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                      onSubmitted: (_) {
                        Future.delayed(const Duration(seconds: 1));
                        if ((myController.text.isNotEmpty)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Home(city: myController.text),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
