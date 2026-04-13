import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Removed 'const' here
      home: DrawPage(),
    );
  }
}

class DrawPage extends StatelessWidget {
  const DrawPage({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Graphics")),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xEC34F8FF), width: 2),
          ),
          child: CustomPaint(
            painter: ShapePainter(),
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    final paint = Paint() // Changed 'point' to 'paint' to match below
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(200, 200), 50, paint);
    canvas.drawRect(const Rect.fromLTWH(50, 250, 200, 100), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false; // Lowercase 's'
}
