import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'colors.dart';
import 'model/product.dart';

/// The menu page where categories are selected.
///
/// Builds all categories as [GestureDetector] widgets which
/// change the state of [ShrineApp] when pressed.
class CategoryMenuPage extends StatelessWidget {
  final Category currentCategory;
  final ValueChanged<Category> onCategoryTap;
  final List<Category> _categories = Category.values;

  const CategoryMenuPage({
    @required this.currentCategory,
    @required this.onCategoryTap,
  });

  /// Wraps the given [Category] in a [GestureDetector].
  ///
  /// If the [Category] is the [currentCategory], the [GestureDetector]
  /// has a dark pink [Container] underlining it.
  Widget _buildCategory(Category category, BuildContext context) {
    final categoryString =
        category.toString().replaceAll('Category.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onCategoryTap(category),
      child: category == currentCategory
          ? Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  categoryString,
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14.0),
                Container(
                  width: 70.0,
                  height: 2.0,
                  color: kShrinePink400,
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                categoryString,
                style: theme.textTheme.bodyText1
                    .copyWith(color: kShrineBrown900.withAlpha(153)),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        color: kShrinePink100,
        child: ListView(
          children: _categories
              .map((Category c) => _buildCategory(c, context))
              .toList(),
        ),
      ),
    );
  }
}
