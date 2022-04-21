import 'package:foodart/backend/cart_controller.dart';
import 'package:foodart/backend/cart_model.dart';
import 'package:foodart/backend/popular_product_model.dart';
import 'package:foodart/backend/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo}) {}
  int quantity = 0;
  var titems = 0;
  var _incartItems = 0;
  int get total => quantity + _incartItems;
  List<ProductModel> _popularProductList = [];
  CartController _cart = Get.find<CartController>();
  List<ProductModel> get popularProductListgetter => _popularProductList;
  bool _isLoaded = false;
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

  void setQuantity(bool increment) {
    if (increment) {
      quantity++;
    } else if (quantity + _incartItems > 0) {
      quantity--;
    }
    update();
  }

  void addItem(ProductModel model) {
    _cart.addItem(model, quantity);
    _incartItems = _cart.checkQuantity(model);
    quantity = 0;
    update();
  }

  void checkQuantity(ProductModel productModel) {
    _incartItems = _cart.checkQuantity(productModel);
  }

  int get totalItems {
    titems = _cart.gettotalitems();
    return titems;
  }

  List<CartModel> getItems() {
    return _cart.getItems();
  }
}
