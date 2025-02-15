import 'package:flutter/widgets.dart';

extension WidgetPadding on Widget {
  Widget withPadding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);

  Widget withAllPadding(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Widget withSymmetricPadding({double horizontal = 0.0, double vertical = 0.0}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );
}

extension WidgetAlignment on Widget {
  Widget center() => Center(child: this);

  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);
}

extension SizedBoxExtension on double {
  Widget get toHeight => SizedBox(height: toDouble());
  Widget get toWidth => SizedBox(width: toDouble());
}
