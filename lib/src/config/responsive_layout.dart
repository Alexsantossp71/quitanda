import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const ResponsiveLayout({super.key, required this.child, this.maxWidth = 1200});

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 900;
  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 600 && w < 900;
  }
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

  static int gridColumns(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= 1200) return 4;
    if (w >= 900) return 3;
    return 2;
  }

  static double hPadding(BuildContext context) {
    if (isMobile(context)) return 8;
    if (isTablet(context)) return 24;
    return 48;
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth), child: child));
  }
}
