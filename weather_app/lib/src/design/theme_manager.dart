import 'package:flutter/material.dart';
import '../services/storage_manager.dart';

///Klasa która odpowiada za przechowywanie motywu oraz informacji
///o nim
///[darkTheme] oraz [lighTheme] posiada
///wszystkie potrzebne informacje aby skutecznie zmieniać motyw
///bez utraty jakości
class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: Colors.grey[850],
    bottomAppBarColor: Colors.grey,
    accentColor: Colors.yellow[600],
    brightness: Brightness.dark,
    buttonColor: Colors.blue,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    scaffoldBackgroundColor: Colors.grey[850],
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
      headline5: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
      headline3: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 56),
      bodyText2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      subtitle2: TextStyle(color: Colors.black),
      subtitle1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.cyan,
    accentColor: Colors.yellow,
    brightness: Brightness.light,
    buttonColor: Colors.purple,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    scaffoldBackgroundColor: Colors.cyan,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
      headline5: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
      headline3: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 56),
      bodyText2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      subtitle2: TextStyle(color: Colors.black),
      subtitle1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ///Konstruktor odpowiada za wczytanie zapisanego stanu
  ///jaki motyw był ostatnio z poprzedniej sesji aplikacji
  //następnie ustawia dany motyw
  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  ///Metoda która słuzy do ręcznego przełączania motywu
  ///wykorzustuje ona dwie prywatne metody
  void reverseMode() async {
    if (_themeData == lightTheme) {
      this._setDarkMode();
    } else {
      this._setLightMode();
    }
  }

  void _setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void _setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
