import 'package:flutter/material.dart';
import 'package:p5/p5.dart';
import 'package:vector_math/vector_math_64.dart' as vMath;

class WaveNoiseWidget extends StatefulWidget {
  final Color color;
  const WaveNoiseWidget({Key key, this.color = Colors.white}) : super(key: key);

  @override
  _WaveNoiseWidgetState createState() => _WaveNoiseWidgetState();
}

class _WaveNoiseWidgetState extends State<WaveNoiseWidget>
    with SingleTickerProviderStateMixin {
  PPainter _waveNoisePainter;
  PAnimator animator;

  @override
  void initState() {
    super.initState();
    animator = new PAnimator(this);
    animator.addListener(() {
      setState(() {
        _waveNoisePainter.redraw();
      });
    });
    animator.run();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    _waveNoisePainter = new _WaveNoisePainter(size, bgColor: widget.color);
    return new Container(
        height: size.height,
        width: size.width,
        child: new PWidget(_waveNoisePainter));
  }
}

class _WaveNoisePainter extends PPainter {
  final Color bgColor;
  final Size _size;
  final int nextIndex = 1;

  final double _increment = 0.009;
  double _zoff = 0.0;

  vMath.SimplexNoise _noise = new vMath.SimplexNoise();
  double _rez = 2;
  int _cols, _rows;
  List<List<vMath.>> _field;

  _WaveNoisePainter(Size screenSize, {this.bgColor = Colors.white})
      : this._size = screenSize;

  void setup() {
    size(_size.width.round(), _size.height.round());
    fullScreen();
    _cols = 1 + (width / _rez).round();
    _rows = 1 + (height / _rez).round();
    _field = List.generate(_cols, (_) => List.generate(_rows, (_) => 0));
  }

  void draw() {
    background(bgColor);

    double _xoff = 0.0;

    for (int i = 0; i < _cols - 1; i++) {
      _xoff += _increment;
      double _yoff = 0.0;
      for (int j = 0; j < _rows - 1; j++) {
        var _noise3d = _noise.noise3D(_xoff, _yoff, _zoff);
        var vector3 = vMath.Vector3.all(vMath.smoothStep(0.92, 0.99, _noise3d));
        _field[i][j] = toColorInt(
            vector3);
        _yoff += _increment;
      }
    }
    _zoff += 0.0005;

    for (int i = 0; i < _cols; i++) {
      for (int j = 0; j < _rows; j++) {
        // var cValue = (_field[i][j] * 255).toInt();
        var cValue = _field[i][j];
        // var color = Color.fromRGBO(cValue, cValue, cValue, 1.0);
        var color = Color(cValue);
        fill(color);
        noStroke();
        var path = new Path();
        path.addRect(Rect.fromLTWH(
            (i * _rez).toDouble(), (j * _rez).toDouble(), _rez, _rez));
        paintCanvas.drawPath(path, fillPaint);
        rect((i * _rez).toDouble(), (j * _rez).toDouble(), _rez, _rez);
      }
    }

    // for (int i = 0; i < _cols - 1; i++) {
    // for (int j = 0; j < _rows - 1; j++) {
    // var cValue = (_field[i][j] * 255).toInt();
    // var color = Color.fromRGBO(cValue, cValue, cValue, 1.0);
    // fill(color);

    // double x = (i * _rez).toDouble();
    // double y = (j * _rez).toDouble();

    // PVector a = new PVector(x + _rez * 0.5, y);
    // PVector b = new PVector(x + _rez, y + _rez * 0.5);
    // PVector c = new PVector(x + _rez * 0.5, y + _rez);
    // PVector d = new PVector(x, y + _rez * 0.5);
    // int state = getState(
    // _field[i][j].round(),
    // _field[i + nextIndex][j].round(),
    // _field[i + nextIndex][j + nextIndex].round(),
    // _field[i][j + nextIndex].round());
    // stroke(Colors.black);
    // strokeWeight(1);
    // drawLines(state, a, b, c, d);
    // }
    // }
  }

  /// Takes a unit Vector3 (all values from 0 to 1)
  /// and returns an int representing color in RGBA format
  /// Vector3(0, 1, 0) -> 0xff00ff00
  int toColorInt(vMath.Vector3 vec) {
    int r = (vec.r * 255).toInt();
    int g = (vec.g * 255).toInt();
    int b = (vec.b * 255).toInt();

    return (b << 0) | (g << 8) | (r << 16) | (255 << 32);
  }

  int getState(int a, int b, int c, int d) {
    return a * 8 + b * 4 + c * 2 + d;
  }

  void drawLines(int state, PVector a, PVector b, PVector c, PVector d) {
    switch (state) {
      case 1:
        drawline(c, d);
        break;
      case 2:
        drawline(b, c);
        break;

      case 3:
        drawline(b, d);
        break;

      case 4:
        drawline(a, b);
        break;

      case 5:
        drawline(a, d);
        drawline(b, c);
        break;

      case 6:
        drawline(a, c);
        break;

      case 7:
        drawline(a, d);
        break;

      case 8:
        drawline(a, d);
        break;
      case 9:
        drawline(a, c);
        break;

      case 10:
        drawline(a, b);
        drawline(c, d);
        break;

      case 11:
        drawline(a, b);
        break;

      case 12:
        drawline(b, d);
        break;

      case 13:
        drawline(b, c);
        break;

      case 14:
        drawline(c, d);
        break;
      default:
    }
  }

  void drawline(PVector v1, PVector v2) {
    line(v1.x, v1.y, v2.x, v2.y);
  }

  void mousePressed() {}

  void mouseDragged() {}
}
