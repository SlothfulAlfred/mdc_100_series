import 'package:test/test.dart';
import '../lib/model/products_repository.dart';
import '../lib/model/product.dart';

void main() {
  test('getById should not fail if index is out of range', () async {
    final product = ProductsRepository.allProducts[0];
    expect(await ProductsRepository.getById(100), product);
  });

  test('getById should work when in range', () async {
    final product = ProductsRepository.allProducts[37];
    expect(await ProductsRepository.getById(37), product);
  });
  group('loadProducts should work for all categories', () {
    test('Category.all', () async {
      var temp = await ProductsRepository.loadProducts(Category.all);
      var len = temp.length;
      expect(len, 38);
    });
    test('Category.home', () async {
      var temp = await ProductsRepository.loadProducts(Category.home);
      var len = temp.length;
      expect(len, 10);
    });
    test('Category.accessories', () async {
      var temp = await ProductsRepository.loadProducts(Category.accessories);
      var len = temp.length;
      expect(len, 9);
    });
    test('Category.clothing', () async {
      var temp = await ProductsRepository.loadProducts(Category.clothing);
      var len = temp.length;
      expect(len, 19);
    });
  });
}
