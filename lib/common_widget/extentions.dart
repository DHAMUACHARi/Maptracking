
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension CommonFunctions on BuildContext{

  bool isWeb() {
    final breakpoint = ResponsiveBreakpoints.of(this).breakpoint;
    return breakpoint.name != MOBILE && breakpoint.name != TABLET;
  }

  bool isTablet() {
    final breakpoint = ResponsiveBreakpoints.of(this).breakpoint;
    return  breakpoint.name == TABLET;
  }

  bool isMobile() {
    final breakpoint = ResponsiveBreakpoints.of(this).breakpoint;
    return breakpoint.name == MOBILE;
  }

  bool isMobileOrTablet() {
    final breakpoint = ResponsiveBreakpoints.of(this).breakpoint;
    return breakpoint.name == MOBILE || breakpoint.name == TABLET;
  }

}