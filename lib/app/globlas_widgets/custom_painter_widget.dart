import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';

class CustomPainterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: CustomPaint(
        painter: _Painter(),
      ),
    );
  }
}

class CustomPainterWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: CustomPaint(
        painter: _Painter2(),
      ),
    );
  }
}

class CustomPainterWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height,
      child: CustomPaint(
        painter: _Painter3(),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    var rect = Offset(5, 5) & size;
    lapiz.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        //Colors.blue[900],
        //Colors.blue[600],
        AppColors.primaryColor,
        AppColors.secondaryColor,
      ],
    ).createShader(rect);
    lapiz.style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(0, size.height * 0.15);

    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.25,
    );

    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.24,
      size.width,
      size.height * 0.40,
    );

    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _Painter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz2 = Paint();
    //var rect = Offset(5, 5) & size;

    lapiz2.color = AppColors.secondaryColor;
    lapiz2.style = PaintingStyle.fill;

    final path2 = Path();
    path2.lineTo(0, size.height * 0.165);
    path2.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.268,
      size.width * 0.5,
      size.height * 0.27,
    );

    path2.quadraticBezierTo(
      size.width * 0.86,
      size.height * 0.24,
      size.width,
      size.height * 0.42,
    );
    path2.lineTo(size.width, 0);
    canvas.drawPath(path2, lapiz2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _Painter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz2 = Paint();
    // var rect = Offset(5, 5) & size;

    lapiz2.color = AppColors.primaryColor;
    lapiz2.style = PaintingStyle.fill;

    final path2 = Path();
    path2.lineTo(0, size.height * 0.10);

    path2.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.30,
      size.width,
      size.height * 0.10,
    );
    path2.lineTo(size.width, 0);
    canvas.drawPath(path2, lapiz2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
