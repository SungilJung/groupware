import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:vector_math/vector_math_64.dart' as vMath;

class PixelNoise extends StatefulWidget {
  final Color color;
  const PixelNoise({Key key, this.color = Colors.white}) : super(key: key);

  @override
  _PixelNoiseState createState() => _PixelNoiseState();
}

class _PixelNoiseState extends State<PixelNoise>
    with SingleTickerProviderStateMixin {
  vMath.SimplexNoise _noise;

  AnimationController _controller;
  Animation _scrollAnim;

  @override
  void initState() {
    _noise = vMath.SimplexNoise();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 30));
    _scrollAnim = IntTween(begin: 1, end: 100).animate(_controller);
    _controller.addStatusListener(_loopingAnimation);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loopingAnimation(status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: AnimatedBuilder(
        animation: _scrollAnim,
        builder: (context, child) {
          return CustomPaint(
            painter: NoisePainter(
              _noise,
              _scrollAnim.value,
              color: Colors.white,
            ),
            isComplex: true,
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          );
        },
      ),
    );
  }
}

class NoisePainter extends CustomPainter {
  final vMath.SimplexNoise _noise;
  final int _xOffset;
  final Color color;
  final double pixelSize; // area to color in
  final double blockSize; // block for each pixel to create surrounding border

  int xorshift32(int x) {
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    return x;
  }

  int seed = 0xFF3BE2C6;

  static const kImageDimension = 1024;

  Future<ui.Image> makeImage() {
    final c = Completer<ui.Image>();
    final pixels = Int32List(kImageDimension * kImageDimension);
    for (int i = 0; i < pixels.length; i++) {
      seed = pixels[i] = xorshift32(seed);
    }
    ui.decodeImageFromPixels(
      pixels.buffer.asUint8List(),
      kImageDimension,
      kImageDimension,
      ui.PixelFormat.rgba8888,
      c.complete,
    );
    return c.future;
  }

  NoisePainter(
    this._noise,
    this._xOffset, {
    this.color = Colors.white,
    this.pixelSize = 2,
  }) : this.blockSize = pixelSize * 1.4;

  @override
  void paint(Canvas canvas, Size size) {
    Paint painting = Paint()..style = PaintingStyle.fill;
    for (var x = 0.0; x < size.width; x++) {
      for (var y = 0.0; y < size.height; y++) {
        canvas.drawImage(null, new Offset(x, y), painting);
      }
    }
  }

  @override
  bool shouldRepaint(NoisePainter oldDelegate) {
    if (oldDelegate._xOffset != (_xOffset)) {
      return true;
    }
    return false;
  }
}
