import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/data_handler/map/home_provider.dart';
import '../../core/global/map/base_urls.dart';
import '../../core/global/map/map_key.dart';
import '../../core/model/address.dart';
import '../../core/model/place_predictions.dart';
import '../../data/api_services.dart';
import '../../data_handler/map/position_provider.dart';
import '../../presentation/widget/progress_dialog.dart';

class ApiMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String? st1 = '', st2 = '', st3 = '', st4 = '';

    String url =
        "$geoCodeBaseUrl?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    try {
      var response = await RequestAssistant.getRequest(url);

      if (response != "failed") {
        // placeAddress = response["results"][0]["formatted_address"];

        print("helpsdjf");
        print(response["results"]);
        print(position.longitude);
        print(position.latitude);

        st1 = response["results"][0]["address_components"][2]["long_name"];
        st2 = response["results"][0]["address_components"][1]["long_name"];
        st3 = response["results"][0]["address_components"][1]["long_name"];
        st4 = response["results"][0]["address_components"][1]["long_name"];
        placeAddress = "${st1!}, ${st2!}, ${st3!}, ${st4!}";

        Address userPickUpAddress = Address(placeName: '');
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.latitude = position.latitude;
        userPickUpAddress.placeName = placeAddress;

        Provider.of<PositionProvider>(context, listen: false)
            .updatePickUpLocation = userPickUpAddress;
      }
    } catch (e) {
      print(e.toString());
    }

    return placeAddress;
  }

  static Future<List<PlacePredictions>> searchAddress(
      String placeName, String sessionToken) async {
    List<PlacePredictions> placePredictionsList = [];
    // String type = "address";
    if (placeName.length > 1) {
      String request =
          '$autoCompleteBaseUrl?input=$placeName&key=$mapKey&sessiontoken=$sessionToken&components=country:ng';

      try {
        var res = await RequestAssistant.getRequest(request);

        if (res == "failed") {
          return [];
        }

        if (res["status"] == "OK") {
          var predictions = res["predictions"];
          print(predictions);

          var placeList = (predictions as List)
              .map((e) => PlacePredictions.fromJson(e))
              .toList();
          placePredictionsList = placeList;
        }
      } catch (e) {
        print(e);
      }
    }
    return placePredictionsList;
  }

  static Future<void> selAddressDetails(String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: " Setting Dropoff , Please wait ... ",
            ));
    String request = '$selAddDetailsBaseUrl?place_id=$placeId&key=$mapKey';

    try {
      var res = await RequestAssistant.getRequest(request);

      Navigator.pop(context);

      if (res == "failed") {
        return;
      }

      if (res["status"] == "OK") {
        Address address = Address(
          placeName: res['result']['name'],
          placeId: placeId,
          latitude: res['result']["geometry"]["location"]["lat"],
          longitude: res['result']["geometry"]["location"]["lng"],
        );
        Provider.of<PositionProvider>(context, listen: false)
            .updateDropOffLocation = address;

        Provider.of<HomeProvider>(context, listen: false).resetDefaultWidget();
        // Navigator.pop(context, "obtainDirection");
      }
    } catch (e) {
      print(e);
    }
  }
}
