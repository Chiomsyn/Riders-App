import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/size.dart';

import '../../../core/global/colors.dart';
import '../../../core/model/place_predictions.dart';
import '../../../data_handler/map/search_prediction.dart';
import '../../../domain/map/api_methods.dart';

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  const PredictionTile({Key? key, required this.placePredictions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchPredictionProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: 70),
      height: size(context).height,
      color: bgColor(context),
      child: TextButton(
        onPressed: () {
          ApiMethods.selAddressDetails(placePredictions.place_id!, context);
        },
        child: Column(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                const Icon(Icons.add_location),
                const SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePredictions.main_text ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Text(placePredictions.secondary_text ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
