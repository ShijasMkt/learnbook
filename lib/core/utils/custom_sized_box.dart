import 'package:flutter/material.dart';
import 'package:learnbook/core/utils/responsive.dart';

//sizedbox with height and width
extension CustomSizedBox on BuildContext {
  SizedBox customSizedBoxHgt(BuildContext context, double height) =>
      SizedBox(height: context.width(height));

  SizedBox customSizedBoxWdt(BuildContext context, double width) =>
      SizedBox(width: context.width(width));
}
