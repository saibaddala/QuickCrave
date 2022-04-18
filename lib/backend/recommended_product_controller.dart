import 'package:foodart/backend/popular_product_model.dart';
import 'package:foodart/backend/popular_product_repo.dart';
import 'package:foodart/backend/recommended_product_repo.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo}) {}

  List<ProductModel> _recommendedProductList = [];

  List<ProductModel> get RecommendedProductListgetter =>
      _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductListFromApi();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Products.fromJson(response.body).productsList);
      _isLoaded = true;
      update();
    } else {}
  }
}
