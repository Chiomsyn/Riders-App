import 'package:flutter/material.dart';

import '../../core/global/enums.dart';

class HomeProvider with ChangeNotifier {
  double bottomPaddingOfMap = 0;
  Show _show = Show.idleTime;
  bool flag = false;
  double _percent = 0.0;
  final controller = DraggableScrollableController();

  double get percent => _percent;
  Show get show => _show;

  set percent(double val) {
    _percent = val;
    notifyListeners();
  }

  set show(Show val) {
    _show = val;
    notifyListeners();
  }

  resetDefaultWidget() {
    percent = 0.2;
    controller.reset();
    notifyListeners();
    _show = Show.rideDetailsContainer;
  }
}
