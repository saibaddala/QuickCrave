import 'package:foodart/backend/models/product_model.dart';
import 'package:foodart/backend/repos/popular_product_repo.dart';
import 'package:foodart/backend/repos/recommended_product_repo.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductsList = [];

  List<ProductModel> get recommendedProductListgetter =>
      _recommendedProductsList;
      
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> fetchRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.fetchRecommendedProductListFromApi();
    if (response.statusCode == 200) {
      _recommendedProductsList = [];
      _recommendedProductsList
          .addAll(Products.fromJson(response.body).productsList);
      _isLoaded = true;
      update();
    } else {}
  }
}
