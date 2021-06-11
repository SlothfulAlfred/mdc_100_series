import 'package:test/test.dart';
import '../lib/model/products_repository.dart';
import '../lib/model/product.dart';

void main() {
  test('getById should not fail if index is out of range', () {
    final product = ProductsRepository.allProducts[0];
    expect(ProductsRepository.getById(100), product);
  });

  test('getById should work when in range', () {
    final product = ProductsRepository.allProducts[37];
    expect(ProductsRepository.getById(37), product);
  });
  group('loadProducts should work for all categories', () {
    test('Category.all', () {
      expect(ProductsRepository.loadProducts(Category.all).length, 38);
    });
    test('Category.home', () {
      expect(ProductsRepository.loadProducts(Category.home).length, 10);
    });
    test('Category.accessories', () {
      expect(ProductsRepository.loadProducts(Category.accessories).length, 9);
    });
    test('Category.clothing', () {
      expect(ProductsRepository.loadProducts(Category.clothing).length, 19);
    });
  });
}
