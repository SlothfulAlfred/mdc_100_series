import 'package:test/test.dart';
import '../../lib/model/cart_model.dart';
import '../../lib/model/product.dart';

void main() {
  group('Adding and removing items: ', () {
    final Product p = Product(
      id: 1,
      name: 'foo',
      isFeatured: false,
      category: Category.all,
      price: 120,
    );

    test('Test adding new items to cart', () {
      final CartModel cart = CartModel();
      cart.addListener(() {
        expect(cart.products.containsKey(p), true);
      });
      cart.add(p);
    });
    test('Test adding items to cart', () {
      final CartModel cart = CartModel();
      cart.add(p);
      int startingValue = cart.products[p];

      cart.addListener(() {
        expect(cart.products[p], greaterThan(startingValue));
      });
      cart.add(p);
    });
    test('Test decrementing items in cart', () {
      final CartModel cart = CartModel();
      cart.add(p);
      cart.add(p);
      int startingValue = cart.products[p];

      cart.addListener(() {
        expect(cart.products[p], lessThan(startingValue));
      });
      cart.remove(p);
    });
    test('Test removing items from cart', () {
      final CartModel cart = CartModel();
      cart.add(p);
      cart.addListener(() {
        expect(cart.products.containsKey(p), false);
      });
      cart.remove(p);
    });
  });
}
