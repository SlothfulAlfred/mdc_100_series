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

import 'package:Shrine/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'backdrop.dart';
import 'cart.dart';
import 'category_menu_page.dart';
import 'colors.dart';
import 'home.dart';
import 'login.dart';
import 'model/product.dart';
import 'model/cart_model.dart';
import 'supplemental/cut_corners_border.dart';
import 'product_page.dart';

/// The main Shrine app.
///
/// Holds the state of the currently selected category.
class ShrineApp extends StatefulWidget {
  @override
  _ShrineAppState createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  /// Sets [_currentCategory] to the selected category.
  void _onCategoryTap(Category c) {
    setState(() {
      _currentCategory = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MaterialApp(
        title: 'Shrine',
        theme: _kShrineTheme,
        home: Backdrop(
          frontLayer: HomePage(
            category: _currentCategory,
          ),
          backLayer: CategoryMenuPage(
            onCategoryTap: _onCategoryTap,
            currentCategory: _currentCategory,
          ),
          frontTitle: Text('SHRINE'),
          backTitle: Text('MENU'),
          currentCategory: _currentCategory,
        ),
        initialRoute: '/login',
        onGenerateRoute: _getRoute,
      ),
    );
  }

  /// Parses a [RouteSettings] and pushes the correct [Route] to
  /// the stack.
  ///
  /// Will throw an error if the route is not '/login', '/', or,
  /// '/product/$id'.
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/login') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => LoginPage(),
        fullscreenDialog: true,
      );
    } else if (settings.name == '/cart') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => CartPage(),
      );
    } else {
      var uri = Uri.parse(settings.name);
      if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'product') {
        var id = uri.pathSegments[1];
        return MaterialPageRoute(
          builder: (context) => ProductPage(id: int.parse(id)),
        );
      }
    }
    assert(false, 'Need to implement $settings.name');
    return null;
  }
}

final ThemeData _kShrineTheme = _buildShrineTheme();

/// Describes the main theme of the Shrine app.
///
/// Uses a primary color of pink with brown accents and a
/// white background.
ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kShrinePink100,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      textTheme: _buildShrineTextTheme(base.textTheme),
      primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: kShrinePink100,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backwardsCompatibility: false,
      ),
      // This is what makes the [TextField] widgets octagonal.
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: CutCornersBorder(
          borderSide: BorderSide(
            width: 2,
            color: kShrineBrown900,
          ),
        ),
        border: CutCornersBorder(),
      ));
}

/// Describes the Shrine text theme.
///
/// Changes certain text styles to the Rubik font
/// and renders them in brown.
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}
