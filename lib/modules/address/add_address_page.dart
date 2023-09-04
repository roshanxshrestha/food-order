import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_button.dart';
import 'package:food_delivery/common/app_text_field.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/modules/address/pick_address_map.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/routes.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(27.7172, 85.3240), zoom: 17);

  late LatLng _initialPosition = const LatLng(27.7172, 85.3240);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    // ignore: unrelated_type_equality_checks
    if (_isLogged && Get.find<UserController>().userModel == Null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        ),
      );
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (_contactPersonName.text.isEmpty) {
            _contactPersonName.text = userController.userModel.name;
            _contactPersonNumber.text = userController.userModel.phone;
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text = locationController.placemark.name ?? "";
              locationController.placemark.locality ?? "";
              locationController.placemark.postalCode ?? "";
              locationController.placemark.country ?? "";
              debugPrint("address in this field is" + _addressController.text);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(Dimension.height10 / 2),
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimension.radius15 / 3),
                        border: Border.all(
                          width: 2,
                          color: AppColors.mainColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              Get.toNamed(
                                AppRoutes.getPickAddressPage(),
                                arguments: PickAddressMap(
                                  fromSignup: false,
                                  fromAddress: true,
                                  googleMapController:
                                      locationController.mapController,
                                ),
                              );
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimension.width20, top: Dimension.height10),
                      child: SizedBox(
                        height: Dimension.height45,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: locationController.addressTypeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                locationController.setAddressTypeIndex(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimension.height20,
                                  vertical: Dimension.height10,
                                ),
                                margin:
                                    EdgeInsets.only(right: Dimension.width10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimension.radius15 / 3),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200]!,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color: locationController.addressTypeIndex ==
                                          index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Dimension.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width20),
                      child: CustomText(
                        text: "Delivery details",
                        fontSize: Dimension.font20 * 0.8,
                      ),
                    ),
                    SizedBox(height: Dimension.height10),
                    AppTextField(
                        textController: _addressController,
                        hintText: "Your address",
                        icon: Icons.map),
                    SizedBox(height: Dimension.height20),
                    AppTextField(
                        textController: _contactPersonName,
                        hintText: "Your name",
                        icon: Icons.person),
                    SizedBox(height: Dimension.height20),
                    AppTextField(
                      textController: _contactPersonNumber,
                      hintText: "Your phone",
                      icon: Icons.phone,
                    ),
                    Container(
                      padding: EdgeInsets.all(Dimension.height20),
                      child: GetBuilder<LocationController>(
                        builder: (locationController) {
                          return CustomButton(
                            buttonText: "Save address",
                            onPressed: () {
                              AddressModel _addressModel = AddressModel(
                                addressType: locationController.addressTypeList[
                                    locationController.addressTypeIndex],
                                contactPersonName: _contactPersonName.text,
                                contactPersonNumber: _contactPersonNumber.text,
                                address: _addressController.text,
                                latitude: locationController.position.latitude
                                    .toString(),
                                longitude: locationController.position.longitude
                                    .toString(),
                              );
                              locationController.addAddress(_addressModel).then(
                                (response) {
                                  if (response.isSuccess) {
                                    Get.toNamed(AppRoutes.getInitial());
                                    Get.snackbar(
                                        "Address", "Added successfully");
                                  } else {
                                    Get.snackbar(
                                        "Address", "Couldn't save address");
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
