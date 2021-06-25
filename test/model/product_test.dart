import 'package:test/test.dart';
import '../../lib/model/product.dart';

void main() {
  test('asset name returns proper path', () {
    final product = Product(
      category: Category.all,
      isFeatured: false,
      price: 12,
      name: 'foo',
      id: 10,
    );
    expect(product.assetName, '10-0.jpg');
  });
  test('asset package is always the same', () {
    final productOne = Product(
      category: Category.all,
      isFeatured: false,
      price: 12,
      name: 'foo',
      id: 10,
    );
    final productTwo = Product(
      category: Category.home,
      isFeatured: true,
      price: 20,
      name: 'bar',
      id: 12,
    );
    expect(
      productOne.assetPackage == productTwo.assetPackage,
      true,
    );
    expect(productOne.assetPackage == 'shrine_images', true);
  });
  test('toString() works properly', () {
    final product = Product(
      category: Category.all,
      id: 120,
      isFeatured: true,
      name: 'foo',
      price: 1220,
    );
    expect(product.toString(), 'foo (id=120)');
  });
}
