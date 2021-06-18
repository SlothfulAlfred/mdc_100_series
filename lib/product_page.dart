import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colors.dart';
import 'supplemental/photo_hero.dart';
import 'model/products_repository.dart';

/// A page that displays information about, and animates, a single
/// product.
///
/// The [id] parameter should be within the range of
/// [ProductsRepository.allProducts].
class ProductPage extends StatelessWidget {
  final int id;
  Future item;

  ProductPage({
    @required this.id,
  }) {
    item = ProductsRepository.getById(id);
  }

  /// Creates the a customized [AppBar] widget for [ProductPage]
  Widget _createAppbar() {
    return AppBar(
      // Looks very similar to the logo in the home page.
      title: Row(
        children: [
          ImageIcon(AssetImage('assets/diamond.png')),
          SizedBox(width: 4.0),
          Text('SHRINE'),
        ],
      ),
      titleSpacing: 0.0,
      elevation: 0.0,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // TODO: Open cart page
            print('cart page');
          },
        )
      ],
    );
  }

  Widget _createImageWidget(product) {
    return AspectRatio(
      aspectRatio: 12 / 12,
      child: Image.asset(
        product.assetName,
        package: product.assetPackage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _createMainPage(context, data) {
    // size of the screen used as a [PhotoHero] parameter
    final sw = MediaQuery.of(context).size.width;
    // formats the price of the product
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        decimalDigits: 0, locale: Localizations.localeOf(context).toString());
    // used to style the text (name, price of the product)
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 46, 16, 8),
          child: Center(
            child: PhotoHero(
                onTap: () => Navigator.pop(context),
                id: id,
                width: sw * 13 / 16,
                child: _createImageWidget(data)),
          ),
        ),
        SizedBox(height: 24),
        // TODO: Change text style
        // TODO: Add buttons to change quantity of items bought
        Text(
          data.name,
          style: theme.textTheme.headline4,
        ),
        Text(
          formatter.format(data.price),
          style: theme.textTheme.headline4,
        ),
      ],
    );
  }

  Widget _createLoadingPage(context) {
    double sw = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: sw * 0.35,
        height: sw * 0.35,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppbar(),
      body: Container(
        color: kShrinePink100,
        // This [Material] Widget keeps the [ProductPage]
        // consistent with the [HomePage] by adding a cut corner
        child: Material(
          elevation: 16,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(46),
            ),
          ),
          color: kShrineBackgroundWhite,
          child: FutureBuilder(
            future: item,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _createMainPage(context, snapshot.data);
              } else {
                return _createLoadingPage(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
