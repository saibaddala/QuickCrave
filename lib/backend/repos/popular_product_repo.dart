import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductListFromApi() async {
    return apiClient.getData(AppConstants.popularProductsUri);
  }
}
