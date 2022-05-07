import 'dart:convert';
import 'package:foodart/backend/models/server_auth_response_model.dart';
import 'package:foodart/reusable_widgets/custom_snackbar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/address_model.dart';
import '../repos/location_repo.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({
    required this.locationRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late Position _position;
  late Position pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  List<AddressModel> _allAddressList = [];
  List<String> _addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;

  String get addressToDisplay => _addressList.first.address;
  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;
  Placemark get placeMark => _placemark;
  Position get position => _position;
  Placemark get pickPlaceMark => _pickPlacemark;
  List<AddressModel> get addressList => _addressList;
  List<String> get addressTypeList => _addressTypeList;
  List<AddressModel> get allAddressList => _allAddressList;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  bool updateAddressData = true;
  bool changeAddress = true;

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if (updateAddressData) {
      _isLoading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            speed: 1,
            speedAccuracy: 1,
            altitude: 1,
          );
        } else {
          pickPosition = Position(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            speed: 1,
            speedAccuracy: 1,
            altitude: 1,
          );
        }

        if (changeAddress) {
          String _address = await getAddressFromGeocode(LatLng(
            cameraPosition.target.latitude,
            cameraPosition.target.longitude,
          ));
          if (fromAddress) {
            _placemark = Placemark(name: _address);
          } else {
            _pickPlacemark = Placemark(name: _address);
          }
        }
      } catch (e) {}
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknown Location Found";
    Response response = await locationRepo.getAddressFromGeoCode(latLng);
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      showCustomSnackBar(message: response.bodyString!);
    }
    update();
    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel = AddressModel.fromJson(_getAddress);
    } catch (e) {}

    return _addressModel;
  }

  void setAddressType(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ServerAuthResponseModel> addAddress(AddressModel addressModel) async {
    _isLoading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ServerAuthResponseModel responseModel;
    if (response.statusCode == 200) {
      getAddressList();
      String message = response.body['message'];
      responseModel = ServerAuthResponseModel(true, message);
      saveUserAddress(addressModel);
    } else {
      responseModel = ServerAuthResponseModel(
        false,
        response.statusText!,
      );
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      for (var element in response.body) {
        _addressList.add(AddressModel.fromJson(element));
        _allAddressList.add(AddressModel.fromJson(element));
      }
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }
}
