import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'model/product.dart';

const double _kFlingVelocity = 2.0;

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
  AnimationController _controller;

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: [
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          child: _FrontLayer(
            child: widget.frontLayer,
            onTap: _toggleBackLayerVisible,
          ),
          rect: layerAnimation,
        ),
      ],
    );
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackLayerVisible() {
    _controller.fling(
      velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackLayerVisible();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      // TODO: Replace title with _BackdropTitle parameter
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: _toggleBackLayerVisible,
      ),
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
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    this.onTap,
    @required this.child,
  });

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
