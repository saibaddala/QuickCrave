import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:foodart/backend/models/address_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getAddressFromGeoCode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.geoCodeUri}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.userAddress) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    Response response = await apiClient.postData(
        AppConstants.addUserAddress, addressModel.toJson());
    return response;
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.addressListUri);
  }

  Future<bool> saveUserAddress(String data) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.userToken)!);
    return await sharedPreferences.setString(AppConstants.userAddress, data);
  }
}
