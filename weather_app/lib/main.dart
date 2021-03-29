import 'package:flutter/material.dart';
import 'package:weather_app/src/pages/search_city.dart';
import 'package:weather_app/src/design/theme_manager.dart';
import 'package:weather_app/src/pages/weather_junior_screen.dart';
import 'package:touchable/touchable.dart';
import 'package:provider/provider.dart';

/// Wykonanie głównej klasy aplikacji musi zostać poprzedzone wywołaniem
/// klasy [ThemeNotifier] która odpowiada za zmianę motywu w "locie"

void main() {
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: MyWeatherApp(),
  ));
}

/// Klasa potrzebna do tego aby zaopatrzyć klasę [WeatherHomeApp] odpowiadającą
/// za nasz główny widget czyli [Scaffold] w klasę [MaterialApp], bez tej klasy
/// nie jest mozliwe korzystanie z np.[MediaQuery]
class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<ThemeNotifier>(
      builder: (context, theme, child) =>
          MaterialApp(theme: theme.getTheme(), home: WeatherHomeApp(theme)));
}

class WeatherHomeApp extends StatelessWidget {
  final ThemeNotifier theme;
  WeatherHomeApp(this.theme);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Weather App", style: Theme.of(context).textTheme.headline6),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          /// Widget odpowiada za wykrywanie gestów
                          /// na klasie [Container], przez co mozna uzyć niestandardowych
                          /// przycisków tak jak w tym przypadku
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WeatherSearchPage()),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 160,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 16),
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 7,
                                      offset: Offset(0.0, 2))
                                ],
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).buttonColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("SENIOR MODE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        JuniorWeatherScreen(city: "Gliwice")),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 160,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 16),
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 7,
                                      offset: Offset(0.0, 2))
                                ],
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).buttonColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("JUNIOR MODE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 250,
              height: 250,
              child: CanvasTouchDetector(
                builder: (context) => CustomPaint(
                  painter: ThemeChanger(context, theme),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Klasa dzięki której jest mozliwe narysowanie słońca w lewym dolnym rogu
/// ekranu, wykorzystuje zewnętrzną bibliotekę, aby mozna było to słońce kliknąć
/// Wymagane jest podanie w klasie parametru [context]
/// oraz [themeNotifier] aby móc zmieniać motyw oraz korzystać z jego kolorsytki

class ThemeChanger extends CustomPainter {
  final BuildContext context;
  final ThemeNotifier themeNotifier;
  ThemeChanger(this.context, this.themeNotifier);

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    var circle = Paint()
      ..color = Theme.of(context).accentColor
      ..style = PaintingStyle.fill;
    //a circle
    var circleBorder = Paint()
      ..color = Colors.grey
      ..strokeWidth = size.width / 110
      ..style = PaintingStyle.stroke;
    myCanvas.drawCircle(Offset(0, 250), 200, circle, onTapDown: (touchEvent) {
      themeNotifier.reverseMode();
    });
    myCanvas.drawCircle(Offset(0, 250), 200, circleBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
