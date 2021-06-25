import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'colors.dart';
import 'model/cart_model.dart';
import 'model/product.dart';

/// A representation of the current cart items
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget appbar = AppBar(
      title: Text('Cart'),
      elevation: 0.0,
      centerTitle: true,
    );
    return Scaffold(
      backgroundColor: kShrineBackgroundWhite,
      appBar: appbar,
      body: Container(
        color: kShrinePink100,
        child: Material(
          elevation: 16.0,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(46))),
          child: _buildList(context),
        ),
      ),
    );
  }

  /// Builds a [ListView] containing the cart items.
  ///
  /// Returns a [Consumer] of [CartModel] so it is automatically
  /// rebuilt whenever [CartModel] changes.
  Widget _buildList(BuildContext context) {
    // formats the prices of the items
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        decimalDigits: 0, locale: Localizations.localeOf(context).toString());

    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // total price of all cart items
        int total = 0;
        for (var p in cart.products.keys) {
          total += p.price * cart.products[p];
        }

        return Column(
          children: [
            // ensures that the list items do not overlap
            // with the cut corner.
            SizedBox(height: 18),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 32),
                children: [
                  for (var p in cart.products.keys)
                    _ListItem(cart.products[p], p, cart.remove, formatter),
                  ...[
                    Divider(height: 4, color: kShrineBrown900),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(formatter.format(total),
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ],
                ],
                physics: BouncingScrollPhysics(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final Product product;
  final int count;
  final Function onRemove;
  final NumberFormat formatter;

  const _ListItem(
      int count, Product product, Function onRemove, NumberFormat formatter)
      : product = product,
        onRemove = onRemove,
        count = count,
        formatter = formatter;

  void _handleTap() {
    onRemove(product);
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;

    return ListTile(
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        onPressed: _handleTap,
      ),
      title: Text(product.name),
      subtitle:
          Text(count.toString() + ' : ' + formatter.format(product.price)),
      leading: Container(
        width: sw * 0.175,
        child: Image.asset(
          product.assetName,
          package: product.assetPackage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
