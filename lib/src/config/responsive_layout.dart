import 'package:flutter/material.dart';

class ResponsiveLayout {
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 600 && w < 900;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  /// Returns number of grid columns based on screen width.
  /// >= 1200 → 4 columns, >= 900 → 3 columns, otherwise 2.
  static int gridColumns(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= 1200) return 4;
    if (w >= 900) return 3;
    return 2;
  }

  /// Returns horizontal padding based on screen width.
  static double horizontalPadding(BuildContext context) {
    if (isMobile(context)) return 8.0;
    if (isTablet(context)) return 24.0;
    return 48.0;
  }

  /// Wraps child in a Center + ConstrainedBox with maxWidth.
  static Widget constrained({required Widget child, double maxWidth = 1200}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
