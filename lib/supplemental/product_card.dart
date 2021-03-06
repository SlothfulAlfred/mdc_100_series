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

import 'package:Shrine/supplemental/photo_hero.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/product.dart';

/// A card displaying information about a [Product]; allows for
/// hero animations.
///
/// The [imageAspectRatio] parameter must not be null or negative.
/// The price of the [Product] this wraps will be formatted automatically
/// by [NumberFormat.SimpleCurrency] into the locale of the user.
class ProductCard extends StatelessWidget {
  ProductCard({this.imageAspectRatio: 33 / 49, this.product})
      : assert(imageAspectRatio == null || imageAspectRatio > 0);

  final double imageAspectRatio;
  final Product product;

  static final kTextBoxHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        decimalDigits: 0, locale: Localizations.localeOf(context).toString());
    final ThemeData theme = Theme.of(context);

    final imageWidget = Image.asset(
      product.assetName,
      package: product.assetPackage,
      fit: BoxFit.cover,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        PhotoHero(
            child: AspectRatio(
              aspectRatio: imageAspectRatio,
              child: imageWidget,
            ),
            id: product.id,
            width: 200,
            onTap: () {
              var uri = '/product/${product.id}';
              Navigator.pushNamed(context, uri);
            }),
        SizedBox(
          height: kTextBoxHeight * MediaQuery.of(context).textScaleFactor,
          // width: 121.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                product == null ? '' : product.name,
                style: theme.textTheme.headline6,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 4.0),
              Text(
                product == null ? '' : formatter.format(product.price),
                style: theme.textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
