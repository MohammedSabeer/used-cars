import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.subtotal;
    }
    return total;
  }

  void addToCart(Product product) {
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(
        id: 0,
        title: '',
        description: '',
        price: 0,
        image: '',
        category: '',
        rating: 0,
      )),
    );

    if (quantity > 0) {
      item.quantity = quantity;
      notifyListeners();
    } else if (quantity == 0) {
      removeFromCart(productId);
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(int productId) {
    return _items.any((item) => item.product.id == productId);
  }
}
