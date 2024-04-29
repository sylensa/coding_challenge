import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
Widget progressCircular({double size = 20,double radius = 10,Color color = Colors.black}) {
  return SizedBox(
      width: size,
      height: size,
      child: CupertinoActivityIndicator(
        radius: radius,
        animating: true,
        color: color,
      ));
}

Widget sText(String? word,
    {double size = 14,
      FontWeight weight = FontWeight.w500,
      Color color = Colors.black,
      TextAlign align = TextAlign.left,
      int maxLines = 5,
      double? lHeight = 1.2,
      double? decorationThickness = 1,
      String family = 'Proxima',
      FontStyle style = FontStyle.normal,
      TextOverflow overflow = TextOverflow.ellipsis,
      TextDecoration textDecoration = TextDecoration.none,
      int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: align,


    style: TextStyle(
      decoration: textDecoration,
      decorationThickness:decorationThickness ,
      height: lHeight,
      fontStyle: style,
      color: color,
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
    ),
  );
}

String dateFormat(DateTime timestamp) {
  return DateFormat.yMMMMEEEEd().format(timestamp);
}