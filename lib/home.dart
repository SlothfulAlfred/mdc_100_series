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
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    return products
        .map(
          (product) => Card(
            clipBehavior: Clip.antiAlias,
            // TODO: Adjust card heights
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // TOOD: Center items on the card
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: Image.asset(
                    product.assetName,
                    package: product.assetPackage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    // TODO: Allign labels to bottom and center
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: theme.textTheme.headline6,
                        maxLines: 1,
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        formatter.format(product.price),
                        style: theme.textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        title: Text("Shrine"),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: "Menu",
          ),
          onPressed: () {
            print('menu button');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'Search',
            ),
            onPressed: () {
              print('search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('filter button');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
