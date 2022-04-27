import 'package:foodart/backend/models/cart_model.dart';
import 'package:foodart/backend/models/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../repos/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  void addItemToCart(ProductModel productModel, int quantity) {
    if (_items.containsKey(productModel.id!)) {
      print("contains");
      _items.update(productModel.id!, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            product: productModel,
            time: DateTime.now().toString());
      });
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(productModel.id!, () {
          return CartModel(
              id: productModel.id,
              name: productModel.name,
              price: productModel.price,
              img: productModel.img,
              quantity: quantity,
              isExist: true,
              product: productModel,
              time: DateTime.now().toString());
        });
      }
    }
    if (_items.containsKey(productModel.id!)) {
      if (_items[productModel.id!]!.quantity == 0) {
        _items.removeWhere((key, value) => key == productModel.id);
      }
    }
  }

  int checkQuantity(ProductModel productModel) {
    if (_items.containsKey(productModel.id!)) {
      var model = _items[productModel.id!];
      return model!.quantity!;
    } else {
      return 0;
    }
  }

  int gettotalitems() {
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity!;
    });
    return total;
  }

  List<CartModel> getItems() {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }
}
