import 'package:flutter/material.dart';
import 'package:groupware/app/color/AppColor.dart';
import 'package:groupware/app/widget/gradiant/RaisedGradientButton.dart';
import 'package:groupware/app/widget/noise/Pixel.dart';
import 'package:groupware/app/widget/neumorphic/BottomLeftNeuClipper.dart';
import 'package:groupware/app/widget/neumorphic/BottomLeftNeuClipperBtm.dart';
import 'package:groupware/app/widget/neumorphic/ClipShadowPath.dart';
import 'package:groupware/app/widget/neumorphic/TopRightNeuClipper.dart';
import 'package:groupware/app/widget/neumorphic/TopRightNeuClipperBtm.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:groupware/app/widget/noise/WaveNoise.dart';

class NeumorphicStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final boxShadow = BoxShadow(
      color: Colors.grey,
      offset: Offset(1, 2),
      blurRadius: 5,
      spreadRadius: 10,
    );
    // Neumorphic colored container with 99% app width
    final widthNeuContainer = Container(
      width: width * 0.99,
      color: AppColor.neumprphicColor,
    );

    // Neumorphic colored container with 99% app height
    final heightNeuContainer = Container(
      height: height * 0.99,
      color: AppColor.neumprphicColor,
    );

    return Material(
      child: Stack(
        children: <Widget>[
          Align(
            child: ClipShadowPath(
              shadow: boxShadow,
              clipper: TopRightNeuClipperBtm(),
              child: widthNeuContainer,
            ),
          ),
          Align(
            alignment: Alignment(30, -1),
            child: ClipShadowPath(
              shadow: boxShadow,
              clipper: TopRightNeuClipper(),
              child: widthNeuContainer,
            ),
          ),
          Align(
            alignment: Alignment(0, 30.5),
            child: ClipShadowPath(
              shadow: boxShadow,
              clipper: BottomLeftNeuClipperBtm(),
              child: heightNeuContainer,
            ),
          ),
          Align(
            alignment: Alignment(0, 80.5),
            child: ClipShadowPath(
              shadow: boxShadow,
              clipper: BottomLeftNeuClipper(),
              child: heightNeuContainer,
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: WaveNoiseWidget(color: Colors.white)),
          // Align(
          //   alignment: Alignment.center,
          //   child: Neumorphic(
          //     margin: EdgeInsets.fromLTRB(
          //         width * 0.05, height * 0.2, width * 0.05, height * 0.3),
          //     style: NeumorphicStyle(
          //         shadowLightColor: Colors.grey[500],
          //         shape: NeumorphicShape.flat,
          //         boxShape:
          //             NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          //         depth: 10,
          //         lightSource: LightSource.right,
          //         color: AppColor.neumprphicColor),
          //     child: Container(),
          //   ),
          // ),
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Padding(
          //         padding: EdgeInsets.only(bottom: height * 0.1),
          //         child: RaisedGradientButton.create(
          //             () => print('hi'),
          //             new LinearGradient(
          //               colors: [
          //                 Color.fromRGBO(255, 214, 0, 1),
          //                 Color.fromRGBO(239, 0, 0, 1)
          //               ],
          //               begin: FractionalOffset.centerLeft,
          //               end: FractionalOffset.centerRight,
          //             ),
          //             new Text("START",
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.grey[200],
          //                 )))))
        ],
      ),
    );
  }
}
