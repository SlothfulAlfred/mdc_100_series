import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'model/product.dart';

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentCategory,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  });

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  // TODO: Add AnimationController Widget

  // TODO: Add BoxConstraints and BuildContext params to _buildStack
  Widget _buildStack() {
    return Stack(
      key: _backdropKey,
      children: [
        // TODO: Wrap backLayer in ExcludeSemantics Widget
        widget.backLayer,
        widget.frontLayer,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      // TODO: Replace Icon with IconButton
      // TODO: Replace title with _BackdropTitle parameter
      leading: Icon(Icons.menu),
      title: Text('SHRINE'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: "search",
          ),
          onPressed: () {
            // TODO: Add open login
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'Filter',
          ),
          onPressed: () {
            // TODO: Add filtering
          },
        ),
      ],
      backwardsCompatibility: false,
    );
    return Scaffold(
      appBar: appBar,
      body: _buildStack(),
    );
  }
}
