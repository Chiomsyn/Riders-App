import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/size.dart';
import 'package:riders_app/data_handler/map/position_provider.dart';
import 'package:riders_app/data_handler/map/request_provider.dart';
import 'package:riders_app/presentation/widget/home/default_bottom_widget.dart';
import 'package:riders_app/presentation/widget/home/prediction_tile.dart';

import '../../core/global/colors.dart';
import '../../core/global/enums.dart';
import '../../data_handler/firebase/auth.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data_handler/map/home_provider.dart';
import '../../data_handler/map/search_prediction.dart';
import '../widget/divider.dart';
import '../widget/home/drawer.dart';
import '../widget/home/menu_btn.dart';
import '../widget/home/search_dest.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final minChildSize = 0.3;
  final maxChildSize = 1.0;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void dispose() {
    Provider.of<PositionProvider>(context, listen: false)
        .controllerGoogleMap!
        .dispose();
    Provider.of<HomeProvider>(context, listen: false).controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthHandler>(context);
    final position = Provider.of<PositionProvider>(context);
    final request = Provider.of<RequestProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    final search = Provider.of<SearchPredictionProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: home.bottomPaddingOfMap, top: 30),
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              position.controllerMapCompleter.complete(controller);
              position.controllerGoogleMap = controller;

              // applyDarkTheme(newGoogleMapController);

              await position.locatePosition(context);

              setState(() {
                home.bottomPaddingOfMap = 300;
              });
            },
          ),
          // drawer button
          Positioned(
              top: 40,
              left: 10,
              child: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: const MenuBtn())),
          Positioned.fill(
              child: Visibility(
            visible: home.show == Show.idleTime,
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                setState(() {
                  final me = 2 * notification.extent - 0.8;
                  if (home.percent > 0.9) {
                    home.flag = true;
                    print(home.percent);
                  }

                  if (me > 0.2 && me < 1.0) {
                    home.percent = me;
                  }

                  if (me < 0.5) {
                    home.flag = false;
                  }
                });

                // final dragRatio = (notification.extent - notification.minExtent) / (notification.maxExtent - notification.minExtent);
                return true;
              },
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                maxChildSize: maxChildSize,
                minChildSize: minChildSize,
                controller: home.controller,
                builder: (context, scrollController) {
                  // controller = scrollController;
                  return Stack(
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 10),
                        opacity:
                            !home.flag ? 1 : (home.flag ? 0 : home.percent),
                        child: DefaultBottomWidget(
                            onClick: () {
                              animatedShow(home);
                              setState(() {});
                            },
                            scrollController: scrollController),
                      ),
                      Visibility(
                        visible: home.percent > 0.9,
                        child: Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 10),
                            opacity: home.flag ? 1 : (home.percent),
                            child: (search.placePredictionsList.isNotEmpty)
                                ? Container(
                                    padding: const EdgeInsets.only(top: 70),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      child: ListView.separated(
                                        padding: const EdgeInsets.all(0.0),
                                        itemBuilder: (context, index) {
                                          return PredictionTile(
                                            placePredictions: search
                                                .placePredictionsList[index],
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const DividerWidget(),
                                        itemCount:
                                            search.placePredictionsList.length,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                      ), // ListView . separated
                                    ),
                                  ) // Padding
                                : Container(
                                    color: bgColor(context),
                                    height: size(context).height,
                                    child: Text("jjjjj"),
                                  ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )),
          Positioned(
              left: 0,
              right: 0,
              top: -400 * (1 - home.percent),
              child: SearchDestinationWidget(
                controller: home.controller,
              ))
          // Positioned(
          //     left: 0.0,
          //     right: 0.0,
          //     bottom: 0.0,
          //     child: AnimatedSize(
          //         curve: Curves.bounceInOut,
          //         duration: const Duration(milliseconds: 160),
          //         child: Visibility(
          //             visible: request.show == Show.idleTime,
          //             child: const DefaultBottomWidget())))
        ],
      ),
    );
  }

  void animatedShow(HomeProvider home) {
    home.controller.animateTo(
      0.9,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}
