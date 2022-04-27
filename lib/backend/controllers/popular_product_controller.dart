import 'package:foodart/backend/models/product_model.dart';
import 'package:foodart/backend/repos/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  bool _isLoaded = false;
  List<ProductModel> get popularProductListgetter => _popularProductList;
 bool get isLoaded => _isLoaded;





 Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductListFromApi();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Products.fromJson(response.body).productsList);
      _isLoaded = true;
      update();
    } else {}
  }





}
