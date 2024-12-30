import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:simplereader/service/filedoc.dart';

class LoggerNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logNavigation(route.settings.name, 'push');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute)async {
    _logNavigation(route.settings.name, 'pop');
    if (ServiceFile.pathPdfUri.isNotEmpty) {
      File filesDelete = File(ServiceFile.pathPdfUri);
      await filesDelete.delete();
    }
  }

  void _logNavigation(String? routeName, String action) {
    if (routeName != null) {
      log("Screen $action: $routeName", name: 'Navigation');
    }
  }
}
