import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> fetchRecommendedProductListFromApi() async {
    return apiClient.getData(AppConstants.recommendedProductsUri);
  }
}
