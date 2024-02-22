import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';

class ArrowDown extends StatelessWidget {
  final Color color;

  const ArrowDown({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ArrowDownPainter(
        color: color,
      ),
    );
  }
}

class _ArrowDownPainter extends CustomPainter {
  final Color color;

  const _ArrowDownPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final xPoint = size.width / 2;
    final height = size.height;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 1.0;

    Path path = Path();
    path.moveTo(xPoint, 0);
    path.lineTo(xPoint, height);
    path = ArrowPath.addTip(path);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
