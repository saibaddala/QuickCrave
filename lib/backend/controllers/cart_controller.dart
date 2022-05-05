import 'package:foodart/backend/models/cart_model.dart';
import 'package:foodart/backend/models/product_model.dart';
import 'package:get/get.dart';
import '../repos/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> items = {};

  List<CartModel> storageItems = [];

  void addItemToCart(ProductModel productModel, int quantity) {
    if (items.containsKey(productModel.id!)) {
      items.update(productModel.id!, (value) {
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
        items.putIfAbsent(productModel.id!, () {
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
    if (items.containsKey(productModel.id!)) {
      if (items[productModel.id!]!.quantity == 0) {
        items.removeWhere((key, value) => key == productModel.id);
      }
    }
    cartRepo.addToCartList(getItems());
  }

  int checkQuantity(ProductModel productModel) {
    if (items.containsKey(productModel.id!)) {
      var model = items[productModel.id!];
      return model!.quantity!;
    } else {
      return 0;
    }
  }

  int gettotalitems() {
    int total = 0;
    items.forEach((key, value) {
      total += value.quantity!;
    });
    return total;
  }

  List<CartModel> getItems() {
    List<CartModel> item = items.entries.map((e) {
      return e.value;
    }).toList();

    return item;
  }

  int get totalAmount {
    var total = 0;
    items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  void getStoredCartListFromRepo() {
    storageItems = cartRepo.getStoredCartList();
    for (var element in storageItems) {
      items.putIfAbsent(element.product!.id!, () => element);
    }
  }

  void addItemsToCartHistoryList() {
    cartRepo.addItemsToCartHistoryList();
    items.clear();
    cartRepo.removeNotCheckedOutCartList();
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryListFromRepo();
  }

  void addToCartListFromPastOrder(Map<int, CartModel> pastItems) {
    items = {};
    items = pastItems;
    cartRepo.addToCartList(getItems());
  }

  void clearAllUserCartDataWhileLoggingOut() {
    cartRepo.clearAllUserCartDataStoredLocally();
    update();
  }
}
