import 'package:flutter/painting.dart';
import 'package:flutter_drawing_board/src/draw_path/draw_path.dart';
import 'package:flutter_drawing_board/src/paint_extension/ex_paint.dart';

import 'paint_content.dart';

/// 橡皮
class Eraser extends PaintContent {
  Eraser({this.color = const Color(0xff000000)});

  Eraser.fromJson({
    required this.color,
    required this.path,
    required Paint paint,
  }) : super.paint(paint);

  /// 擦除路径
  DrawPath path = DrawPath();
  final Color color;

  @override
  void startDraw(Offset startPoint) {
    path.moveTo(startPoint.dx, startPoint.dy);
  }

  @override
  void drawing(Offset nowPoint) => path.lineTo(nowPoint.dx, nowPoint.dy);

  @override
  void draw(Canvas canvas, Size size, bool deeper) {
    if (deeper)
      canvas.drawPath(path, paint.copyWith(blendMode: BlendMode.clear));
    else
      canvas.drawPath(path, paint.copyWith(color: color));
  }

  @override
  Eraser copy() => Eraser(color: color);

  @override
  Eraser fromJson(Map<String, dynamic> data) {
    return Eraser.fromJson(
      color: Color(data['color'] as int),
      path: DrawPath.fromJson(data['path'] as Map<String, dynamic>),
      paint: jsonToPaint(data['paint'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': 'Eraser',
      'color': color.value,
      'path': path.toJson(),
      'paint': paint.toJson(),
    };
  }
}
