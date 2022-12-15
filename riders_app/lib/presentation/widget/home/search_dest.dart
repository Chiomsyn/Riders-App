import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/global/colors.dart';
import '../../../core/model/place_predictions.dart';
import '../../../data_handler/map/home_provider.dart';
import '../../../data_handler/map/position_provider.dart';
import '../../../data_handler/map/search_prediction.dart';
import '../../../domain/map/api_methods.dart';

class SearchDestinationWidget extends StatefulWidget {
  DraggableScrollableController controller;
  SearchDestinationWidget({required this.controller, super.key});

  @override
  State<SearchDestinationWidget> createState() =>
      _SearchDestinationWidgetState();
}

class _SearchDestinationWidgetState extends State<SearchDestinationWidget> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();

  String? _sessionToken;
  var uuid = const Uuid();

  void onSearchChanged(
      String placeName, SearchPredictionProvider search) async {
    search.searchedString = placeName;
    print(placeName);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final position = Provider.of<PositionProvider>(context);
    final search = Provider.of<SearchPredictionProvider>(context);

    pickUpTextEditingController.text = position.pickUpLocation!.placeName;
    return SafeArea(
      child: Material(
        // elevation: 10,
        color: bgColor(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        home.percent = 0.2;
                        home.flag = false;
                        widget.controller.reset();
                      },
                      child: const Icon(Icons.arrow_back)),
                  const Center(
                    child: Text(
                      " Set Drop Off ",
                      style:
                          TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Image.asset(
                    "assets/images/pickicon.png",
                    height: 16.0,
                    width: 16.0,
                  ),
                  const SizedBox(
                    width: 18.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                            controller: pickUpTextEditingController,
                            decoration: InputDecoration(
                                hintText: " PickUp Location ",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 11.0,
                                    top: 8.0,
                                    bottom: 8.0))), // TextField
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Image.asset(
                    "assets/images/desticon.png",
                    height: 16.0,
                    width: 16.0,
                  ),
                  const SizedBox(
                    width: 18.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                            onChanged: (val) => onSearchChanged(val, search),
                            controller: dropOffTextEditingController,
                            decoration: InputDecoration(
                                hintText: "Where To?",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 11.0,
                                    top: 8.0,
                                    bottom: 8.0))), // TextField
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
