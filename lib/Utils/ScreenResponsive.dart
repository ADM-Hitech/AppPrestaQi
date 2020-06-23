import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ScreenResponsive {
  
  final BuildContext context;

  ScreenResponsive(this.context);

  double get width {
    return MediaQuery.of(context).size.width;
  }

  double get height {
    return MediaQuery.of(context).size.height;
  }

  bool get isMobil {
    return this.width <= 767.0;
  }

  bool get isTablet {
    return this.width >= 768.0 && this.width <= 1023.0;
  }

  bool get isDesktop {
    return this.width >= 1024.0;
  }

  double get widthContainer {
    return width > 800 ? width * .50 : width * .90;
  }

  double get widthContainerHeader {
    return width > 944 ? width * .50 : width * .90;
  }

  double get widthDescriptionVideo {
    double result = width > 800 ? ((width * .50) * .60 - 15.0) : widthContainer;
    return result > 340 ? result : width;
  }

  double get widthButtonVideo {
    double result = width > 800 ? (width * .50) * .40 : width;
    return result > 237 ? result : width;
  }

  double get widthMenu {
    return isDesktop ? 80 : 0;
  }

  double get heightAppBar {
    return 70.0;
  }
}