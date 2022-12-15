import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../core/model/place_predictions.dart';
import '../../domain/map/api_methods.dart';

class SearchPredictionProvider with ChangeNotifier {
  String? _sessionToken;
  var uuid = const Uuid();

  List<PlacePredictions> placePredictionsList = [];

  String _searchedString = '';
  String get searchedString => _searchedString;

  set searchedString(String val) {
    _searchedString = val;
    print(val);
    searchPlace();
    notifyListeners();
  }

  void searchPlace() async {
    _sessionToken ??= uuid.v4();

    placePredictionsList =
        await ApiMethods.searchAddress(_searchedString, _sessionToken!);

    print(placePredictionsList);
    notifyListeners();
  }
}
