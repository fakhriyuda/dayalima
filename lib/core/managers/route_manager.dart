import 'package:dayagram/core/common/routes.dart';
import 'package:dayagram/features/home/presentation/home_page.dart';
import 'package:dayagram/features/upload/presentation/upload_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.ROOT:
      return MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
        settings: settings,
      );
    case Routes.UPLOAD_PAGE:
      return MaterialPageRoute(
        builder: (BuildContext context) => UploadPage(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
        settings: settings,
      );
  }
}
