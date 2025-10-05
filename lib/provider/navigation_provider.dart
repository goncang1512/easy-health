import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationProvider with ChangeNotifier {
  StatefulNavigationShell? _shell;

  void setShell(StatefulNavigationShell shell) {
    _shell = shell;
  }

  void clearShell() {
    _shell = null;
    notifyListeners();
  }

  StatefulNavigationShell? get shell => _shell;
}
