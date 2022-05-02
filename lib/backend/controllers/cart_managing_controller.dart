import 'package:foodart/backend/controllers/cart_controller.dart';
import 'package:foodart/backend/models/cart_model.dart';
import 'package:foodart/backend/models/product_model.dart';
import 'package:get/get.dart';

class CartManagingController extends GetxController {
  int quantity = 0;
  var titems = 0;
  var _incartItems = 0;

  int get total => quantity + _incartItems;
  final CartController _cart = Get.find<CartController>();

  void setQuantity(bool increment) {
    if (increment) {
      quantity++;
    } else if (quantity + _incartItems > 0) {
      quantity--;
    }
    update();
  }

  void addItem(ProductModel model) {
    _cart.addItemToCart(model, quantity);
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
