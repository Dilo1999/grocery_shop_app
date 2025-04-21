// cart.dart

List<Map<String, dynamic>> cartItems = [];

void addToCart(Map<String, dynamic> product) {
  cartItems.add({
    ...product,
    'quantity': product['quantity'] ?? 1,
    'selected': product['selected'] ?? true,
  });
}
