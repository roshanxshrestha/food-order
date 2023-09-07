import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_button.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/modules/address/widgets/search_location_dialog_page.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/routes.dart';
import '../../utils/colors.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(27.7172, 85.3240);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        );

        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);
                      },
                      onMapCreated: (GoogleMapController mapController) {
                        _mapController = mapController;
                        if (!widget.fromAddress) {
                          print("not from address");
                        }
                      },
                    ),
                    Center(
                      child: !locationController.loading
                          ? Image.asset(
                              "assets/image/pick_marker.png",
                              height: 50,
                              width: 50,
                            )
                          : const CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                    ),
                    Positioned(
                      top: Dimension.height45,
                      left: Dimension.width20,
                      right: Dimension.width20,
                      child: InkWell(
                        onTap: () => Get.dialog(
                          LocationDialogue(mapController: _mapController),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimension.width10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(
                              Dimension.radius20 / 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: Dimension.iconSize24,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Text(
                                  locationController.pickPlacemark.name ?? "",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimension.font14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: Dimension.width10),
                              Icon(
                                Icons.search,
                                size: Dimension.iconSize24,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Dimension.height45 * 2,
                      left: Dimension.width20,
                      right: Dimension.width20,
                      child: locationController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ))
                          : CustomButton(
                              buttonText: locationController.inZone
                                  ? widget.fromAddress
                                      ? "Pick address"
                                      : "Pick location"
                                  : "Not available in this zone",
                              onPressed: (locationController.buttonDisabled ||
                                      locationController.loading)
                                  ? null
                                  : () {
                                      if (locationController
                                                  .pickPosition.latitude !=
                                              0 &&
                                          locationController
                                                  .pickPlacemark.name !=
                                              null) {
                                        if (widget.fromAddress) {
                                          if (widget.googleMapController !=
                                              null) {
                                            debugPrint(
                                                "now you clicked on this");
                                            widget.googleMapController!
                                                .moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                    locationController
                                                        .pickPosition.latitude,
                                                    locationController
                                                        .pickPosition.longitude,
                                                  ),
                                                ),
                                              ),
                                            );
                                            locationController
                                                .setAddAddressData();
                                          }
                                          //Get.back(); creates update proble
                                          Get.toNamed(
                                              AppRoutes.getAddressPage());
                                        }
                                      }
                                    },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
