import 'package:flutter/cupertino.dart';

extension SizeExtentions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenheight => MediaQuery.of(this).size.height;

  double percentWidth(double percent) => screenWidth * percent;
  double percentheight(double percent) => screenheight * percent;
}
