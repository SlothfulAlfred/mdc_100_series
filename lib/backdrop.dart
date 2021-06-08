import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';
import 'model/product.dart';
import 'login.dart';

const double _kFlingVelocity = 2.0;

/// The multi-layered home page comprised of a [CategoryMenuPage] under
/// an [AsymmetricView].
///
/// This widget controls the animations of all its children using an
/// [AnimationController].
class Backdrop extends StatefulWidget {
  /// The current selected category of items to display.
  final Category currentCategory;

  /// The initially visible layer of the widget.
  final Widget frontLayer;

  /// The layer behind [frontLayer], designed to be a menu.
  final Widget backLayer;

  /// The [AppBar]'s [title] parameter to be shown when
  /// [frontLayer] is visible.
  final Widget frontTitle;

  /// The [AppBar]'s [title] parameter to be shown when
  /// [backLayer] is visible.
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

  /// Describes the stack of [widget.frontLayer] and [widget.backLayer]
  /// with a simple animation.
  ///
  /// Uses a [RelativeRectTween] and a [PositionedTransition] to
  /// smoothly alternate between the two widgets on the stack.
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

  /// The visibility of [widget.frontLayer].
  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  /// Toggles the visibility of [widget.backLayer].
  ///
  /// Drives the same animation but with different velocities depending
  /// on [_frontLayerVisible].
  void _toggleBackLayerVisible() {
    _controller.fling(
      velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );
  }

  /// Initializes the [AnimationController].
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  /// Disposes of the [AnimationController].
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Toggles menu visibility if a new category is selected.
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
      title: _BackdropTitle(
        // [_controller] is passed to [_BackdropTitle] to drive
        // the animations.
        listenable: _controller.view,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
        onPressed: _toggleBackLayerVisible,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: "login",
          ),
          // Leads to the login page on press
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'login',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
      backwardsCompatibility: false,
    );
    return Scaffold(
      appBar: appBar,
      // A [LayoutBuilder] is used here to prevent render overflow
      // errors when the menu is brought down, as this rebuilds the
      // layout whenever the constraints are changed.
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}

/// The stylized home page of the Shrine app.
///
/// Includes a [BeveledRectangleBorder] to cut the top-left corner
/// and a [GestureDetector] that allows menu opening by clicking
/// the top of the screen, just under the appbar.
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

/// An animated title for the appbar, different from [BrandedIcon].
///
/// This widget manages the animations for the title of the appbar
/// when opening and closing the menu. [Opacity] and [FractionalTranslation]
/// widgets are used to fly and fade in/out the titles when opening the
/// menu. [AnimatedWidget] handles the rebuliding whenever the animation
/// triggers.
class _BackdropTitle extends AnimatedWidget {
  final VoidCallback onPressed;
  final Widget frontTitle;
  final Widget backTitle;
  final Animation<double> _listenable;

  const _BackdropTitle({
    @required this.onPressed,
    @required this.frontTitle,
    @required this.backTitle,
    @required Listenable listenable,
  })  : _listenable = listenable,
        super(listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = _listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.headline6,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        SizedBox(
          width: 72,
          child: IconButton(
            padding: const EdgeInsets.only(right: 8.0),
            onPressed: this.onPressed,
            icon: BrandedIcon(
                animation:
                    animation), /*AnimatedIcon(
              progress: animation,
              icon: AnimatedIcons.close_menu,
            ),
            */
          ),
        ),
        Stack(children: <Widget>[
          Opacity(
            opacity: CurvedAnimation(
              parent: ReverseAnimation(animation),
              curve: Interval(0.5, 1),
            ).value,
            child: FractionalTranslation(
              translation: Tween<Offset>(
                begin: Offset.zero,
                end: Offset(0.5, 0.0),
              ).evaluate(animation),
              child: backTitle,
            ),
          ),
          Opacity(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5, 1.0),
            ).value,
            child: FractionalTranslation(
              translation: Tween<Offset>(
                begin: Offset(-0.25, 0.0),
                end: Offset.zero,
              ).evaluate(animation),
              child: frontTitle,
            ),
          ),
        ])
      ]),
    );
  }
}

/// A custom icon that represents the Shrine theme.
///
/// When the animation is complete, [BrandedIcon] appears
/// as a slanted menu with the Shrine logo beside it.
/// When the aniamtion progress is 0.0, [BrandedIcon] appears
/// as a lone Shrine logo.
///
/// This widget uses [Opacity] and [FractionalTranslation] to
/// fade out the slanted menu and reposition the Shrine logo when
/// the animation is triggered.
class BrandedIcon extends StatelessWidget {
  const BrandedIcon({
    Key key,
    @required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Opacity(
        opacity: animation.value,
        child: ImageIcon(
          AssetImage('assets/slanted_menu.png'),
        ),
      ),
      FractionalTranslation(
        translation: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(1.0, 0.0),
        ).evaluate(animation),
        child: ImageIcon(AssetImage('assets/diamond.png')),
      )
    ]);
  }
}
