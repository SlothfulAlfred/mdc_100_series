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

import 'package:flutter/material.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'supplemental/asymmetric_view.dart';
import 'supplemental/loading_animation.dart';

class HomePage extends StatelessWidget {
  final Category category;
  Future items;
  HomePage({this.category = Category.all})
      : items = ProductsRepository.loadProducts(category);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: items,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AsymmetricView(products: snapshot.data);
          } else {
            double width = MediaQuery.of(context).size.width * 0.35;
            return Center(
              child: Container(
                child: LoadingAnimation(), // CircularProgressIndicator(),
                width: width,
                height: width,
              ),
            );
          }
        });
  }
}
