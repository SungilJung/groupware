import 'package:flutter/material.dart';
import 'package:groupware/app/screen/NeumorphicStartPage.dart';
import 'package:groupware/app/theme/AppTheme.dart';
// 
void main() => runApp(MyApp());
// 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic Widgets',
      theme: AppTheme.defaultTheme,
      home: NeumorphicStartPage(),
    );
  }
}

// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:fast_noise/fast_noise.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' as vMath;

// void main() async => runApp(MaterialApp(home: Root()));

// /// Waits till [ui.Image] is generated and renders
// /// it using [CustomPaint] to render it. Allows use of [MediaQuery]
// class Root extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ui.Image>(
//       future: generateImage(MediaQuery.of(context).size),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return CustomPaint(
//             // Passing our image
//             painter: ImagePainter(image: snapshot.data),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             ),
//           );
//         }
//         return Text('Generating image...');
//       },
//     );
//   }
// }

// /// Paints given [ui.Image] on [ui.Canvas]
// /// does not repaint
// class ImagePainter extends CustomPainter {
//   ui.Image image;

//   ImagePainter({this.image});

//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawImage(image, Offset.zero, Paint());
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return image != (oldDelegate as ImagePainter).image;
//   }
// }

// /// Generates a [ui.Image] with certain pixel data
// Future<ui.Image> generateImage(Size size) async {
//   int width = size.width.ceil();
//   int height = size.height.ceil();

//   /// PerlinNoise generator, there're lots of parameters
//   /// to tweak and lots of effects possible to produce
//   var noise = PerlinNoise(
//       octaves: 1, frequency: 0.006, fractalType: FractalType.RigidMulti);

//   var completer = Completer<ui.Image>();
//   Int32List pixels = Int32List(width * height);

//   for (var x = 0; x < width; x++) {
//     for (var y = 0; y < height; y++) {
//       int index = y * width + x;

//       // Compute pixel luminance
//       var luminance = noise.getPerlinFractal2(x.toDouble(), y.toDouble());

//       // Turn luminance into actual color
//       // pixels[index] = luminance > .93 ? Colors.white.value : Colors.black.value;
//       // pixels[index] = generatePixel(x, y, size);

//       pixels[index] = toColorInt(
//         vMath.Vector3.all(
//           // [smoothStep] will return value between 0..1
//           // which is growing smoothly when luminance is between
//           // 0.92 and 0.99
//           vMath.smoothStep(0.92, .99, luminance),
//         ),
//       );
//     }
//   }

//   ui.decodeImageFromPixels(
//     pixels.buffer.asUint8List(),
//     width,
//     height,
//     ui.PixelFormat.bgra8888,
//     (ui.Image img) {
//       completer.complete(img);
//     },
//   );

//   return completer.future;
// }

// /// Takes a unit Vector3 (all values from 0 to 1)
// /// and returns an int representing color in RGBA format
// /// Vector3(0, 1, 0) -> 0xff00ff00
// int toColorInt(vMath.Vector3 vec) {
//   int r = (vec.r * 255).toInt();
//   int g = (vec.g * 255).toInt();
//   int b = (vec.b * 255).toInt();

//   return (b << 0) | (g << 8) | (r << 16) | (255 << 32);
// }
