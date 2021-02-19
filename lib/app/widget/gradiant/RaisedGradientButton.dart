import 'package:flutter/material.dart';

enum RaisedGradientShape { roundedRec }

extension RaisedGradientShapeExtension on RaisedGradientShape {
  ShapeBorder get shape {
    switch (this) {
      case RaisedGradientShape.roundedRec:
        return RoundedRectangleBorder(
          borderRadius: borderRadius,
        );
      default:
        return null;
    }
  }

  BorderRadius get borderRadius {
    switch (this) {
      case RaisedGradientShape.roundedRec:
        return BorderRadius.circular(60);
      default:
        return null;
    }
  }
}

class RaisedGradientButton {
  static RaisedButton create(Function onPressed, gradient, Widget child,
      {RaisedGradientShape rgShape = RaisedGradientShape.roundedRec}) {
    return RaisedButton(
      onPressed: onPressed,
      shape: rgShape.shape,
      padding: EdgeInsets.all(0),
      elevation: 10,
      splashColor: gradient.colors.first,
      child: Ink(
        decoration: new BoxDecoration(
          borderRadius: rgShape.borderRadius,
          gradient: gradient,
        ),
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
        child: child,
      ),
    );
  }
}
