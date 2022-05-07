import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/location_controller.dart';
import 'package:foodart/reusable_widgets/custom_loading_screen.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressFromMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressFromMap(
      {Key? key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressFromMap> createState() => _PickAddressFromMapState();
}

class _PickAddressFromMapState extends State<PickAddressFromMap> {
  late LatLng _initialPosition;
  late GoogleMapController mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: ((locationController) {
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
                    ),
                    Center(
                        child: locationController.isLoading
                            ? Image.asset(
                                "assets/images/pick_marker.png",
                                width: Dimensions.width40,
                                height: Dimensions.height45,
                              )
                            : const CustomLoadingScreen()),
                    Positioned(
                      top: Dimensions.height40,
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      child: Container(
                        height: Dimensions.height50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius10,
                          ),
                        ),
                        child: Row(children: [
                          Icon(
                            Icons.location_on,
                            size: Dimensions.iconSize25,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Text(
                              '${locationController.pickPlaceMark.name}??" "',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.fontSize20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
