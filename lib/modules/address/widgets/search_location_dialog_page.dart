import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({Key? key, required this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimension.width10),
      alignment: Alignment.topCenter,
      child: Material(
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: "search location",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.radius15),
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  width: 0,
                ),
              ),
              hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimension.font14,
                  ),
            ),
          ),
          // suggests as we type
          onSuggestionSelected: (Prediction suggestion) {
            Get.find<LocationController>().setLocation(
                suggestion.placeId!, suggestion.description!, mapController);
            Get.back();
          },

          suggestionsCallback: (pattern) async {
            return await Get.find<LocationController>()
                .searchLocation(context, pattern);
          },

          itemBuilder: (context, Prediction suggestion) {
            return Padding(
              padding: EdgeInsets.all(Dimension.width10),
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  Expanded(
                    child: Text(
                      suggestion.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: Dimension.font14,
                          ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}