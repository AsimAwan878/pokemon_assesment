

import 'package:flutter/material.dart';

double screenHeight(BuildContext context,double percent) {
  return MediaQuery.of(context).size.height * percent;
}
double screenWidth(BuildContext context,double percent) {
  return MediaQuery.of(context).size.width * percent;
}

EdgeInsets globalHorizontalPadding36(BuildContext context) =>
    EdgeInsets.symmetric(horizontal: screenWidth(context, 0.056));

const Color defaultColor = Color(0xFFebce24);
const Color defaultDarkColor =Color(0xFF084c91);

TextStyle text28p500(BuildContext context, {Color color = Colors.black}) =>
    TextStyle(
      fontSize: screenHeight(context, 0.028),
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins',
      color: color,
    );

TextStyle text22p600(BuildContext context, {Color color = Colors.black}) =>
    TextStyle(
      fontSize: screenHeight(context, 0.022),
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: color,
    );