import 'package:coding_challenge/core/utils/colors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
// progress indicator
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

// custom Text widget
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

// date format function
String dateFormat(DateTime timestamp) {
  return DateFormat.yMMMMEEEEd().format(timestamp);
}


// convert formatted date to DateTime
convertToDateTime(String dateString){
  DateFormat inputDateFormat = DateFormat("EEEE, MMMM d, yyyy",);
  DateTime dateTime = inputDateFormat.parse(dateString);
  return dateTime;
}

// custom gradient function
LinearGradient linearGradient =  const LinearGradient(
  begin: Alignment.topCenter,
  end:  Alignment.bottomCenter,
  colors: [
    Color(0XFFBB0027),
    Color(0XFFFD4041),
  ],
  stops: [0.5, 0.7458],
);

// button style funcction
buttonStyle({Color textColor = Colors.white,Color buttonColor = appMainColor,FontWeight fontWeight = FontWeight.bold}) {
  return ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: buttonColor,

    padding: const EdgeInsets.all(
      15,
    ),
    textStyle:  TextStyle(
      color: textColor,
      fontWeight:fontWeight ,
      fontSize: 18,
    ),
  );
}