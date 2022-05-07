import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/auth_controller.dart';
import 'package:foodart/backend/controllers/location_controller.dart';
import 'package:foodart/backend/controllers/user_controller.dart';
import 'package:foodart/backend/models/address_model.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_snackbar.dart';
import 'package:foodart/reusable_widgets/custom_textfield_widget.dart';
import 'package:foodart/screens/pick_address_from_map.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utilities/dimensions.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController contactPersonNameController = TextEditingController();
  TextEditingController contactPersonNumberController = TextEditingController();

  late bool _isLogged;

  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);

  late LatLng _initialPosition = const LatLng(13.6288, 79.4192);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().isuserLoggedIn();
    if (_isLogged) {
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
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']),
        ),
      );

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: ((userController) /*userController.userModel != null &&*/
          {
        if (contactPersonNameController.text.isEmpty) {
          contactPersonNameController.text = userController.userModel.name;
          contactPersonNumberController.text = userController.userModel.phone;
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(
          builder: ((locationController) {
            addressController.text =
                '${locationController.placeMark.name ?? ''}'
                '${locationController.placeMark.locality ?? ''} '
                '${locationController.placeMark.postalCode ?? ''} '
                '${locationController.placeMark.country ?? ''}'
                '${locationController.placeMark.street ?? ''}';

            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.mainColor,
                elevation: 0,
                shadowColor: Colors.white,
                title: const Center(
                  child: Text(
                    "Address page",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.75,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(children: [
                      GoogleMap(
                        onTap: (latlng) {
                          Get.toNamed(RouteHelper.getPickAddressFromMapScreen(),
                              arguments: PickAddressFromMap(
                                fromSignUp: false,
                                fromAddress: true,
                                googleMapController:
                                    locationController.mapController,
                              ));
                        },
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 17,
                        ),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: () {
                          locationController.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: (position) {
                          _cameraPosition = position;
                        },
                        onMapCreated: (GoogleMapController controller) {
                          locationController.setMapController(controller);
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  SizedBox(
                    height: Dimensions.height50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              locationController.setAddressType(index);
                            },
                            child: Container(
                              width: Dimensions.width50,
                              margin: EdgeInsets.only(left: Dimensions.width15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[500]!,
                                        blurRadius: 5,
                                        spreadRadius: 1)
                                  ]),
                              child: Icon(
                                index == 0
                                    ? Icons.home_filled
                                    : index == 1
                                        ? Icons.work
                                        : Icons.location_on,
                                color:
                                    locationController.addressTypeIndex == index
                                        ? AppColors.mainColor
                                        : Theme.of(context).disabledColor,
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: Dimensions.width15),
                              child: const BigText(
                                text: "Delivery Address",
                                textColor: AppColors.mainBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            CustomTextFieldWidget(
                                textController: addressController,
                                hintText: "Address",
                                iconData: Icons.location_city),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: Dimensions.width15),
                              child: const BigText(
                                text: "Name",
                                textColor: AppColors.mainBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            CustomTextFieldWidget(
                                textController: contactPersonNameController,
                                hintText: "Name",
                                iconData: Icons.person),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: Dimensions.width15),
                              child: const BigText(
                                text: "Mobile Number",
                                textColor: AppColors.mainBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            CustomTextFieldWidget(
                                textController: contactPersonNumberController,
                                hintText: "Mobile",
                                iconData: Icons.phone),
                            SizedBox(
                              height: Dimensions.height25,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  AddressModel addressModel = AddressModel(
                                    addressType: locationController
                                            .addressTypeList[
                                        locationController.addressTypeIndex],
                                    contactPersonName:
                                        contactPersonNameController.text,
                                    contactPersonNumber:
                                        contactPersonNumberController.text,
                                    address: addressController.text,
                                    latitude: locationController
                                        .position.latitude
                                        .toString(),
                                    longitude: locationController
                                        .position.longitude
                                        .toString(),
                                  );
                                  locationController
                                      .addAddress(addressModel)
                                      .then((response) {
                                    if (response.isSuccess) {
                                      Get.toNamed(RouteHelper.getMainPage());
                                      showCustomSnackBar(
                                          message: "Address saved succesfully",
                                          title: "Address",
                                          isError: false);
                                    } else {
                                      showCustomSnackBar(
                                          message: "Could not save address",
                                          title: "Error",
                                          isError: true);
                                    }
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: Dimensions.height50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    color: AppColors.mainColor,
                                  ),
                                  child: const BigText(
                                    text: "Save address",
                                    textColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      }),
    );
  }
}
