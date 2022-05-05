import 'package:foodart/backend/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.userToken;
    _mainHeaders = {
      'Content-type': "application/json; charset=UTF-8",
      'Authorization': "Bearer $token"
    };
  }

  Future<Response> getData(
    String uri,
  ) async {
    try {
      final Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(
      String uri, Map<String, dynamic> authjsonData) async {
    try {
      Response response = await post(uri, authjsonData, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': "application/json; charset=UTF-8",
      'Authorization': "Bearer $token"
    };
  }
}
