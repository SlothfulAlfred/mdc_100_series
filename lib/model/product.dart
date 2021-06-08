// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/foundation.dart';

enum Category {
  all,
  accessories,
  clothing,
  home,
}

/// A model of a Shrine product.
class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    @required this.price,
  })  : assert(category != null),
        assert(id != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(price != null);

  /// The category of this product.
  final Category category;

  /// The identified of this product.
  final int id;

  /// True if this product is featured.
  final bool isFeatured;

  /// The name of this product.
  final String name;

  /// The price of this product.
  final int price;

  /// The name of this product's image.
  String get assetName => '$id-0.jpg';

  /// The asset bundle of Shrine images.
  String get assetPackage => 'shrine_images';

  @override
  String toString() => "$name (id=$id)";
}
