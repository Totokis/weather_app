import 'package:flutter/material.dart';

///Klasa odpowiedzialna za rysowanie tego samego fragmentu koła na
///poszczególnych ekranach
///Ta wersja nie posiada obsługi zdarzeń takich jak np. naciśnięcie.
class SunPainter extends CustomPainter {
  final BuildContext context;

  SunPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    var circle = Paint()
      ..color = Theme.of(context).accentColor
      ..style = PaintingStyle.fill;
    var circleBorder = Paint()
      ..color = Colors.grey
      ..strokeWidth = size.width / 110
      ..style = PaintingStyle.stroke;
    //a circle
    canvas.drawCircle(Offset(-500, 50), 1000, circle);
    canvas.drawCircle(Offset(-500, 50), 1000, circleBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
