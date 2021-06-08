import 'package:Shrine/model/products_repository.dart';
import 'package:flutter/material.dart';

/// A wrapper for convenient hero animations of children, usually images.
///
/// The [child] parameter is wrapped in an [InkWell] for tap detection
/// and further a [Material] so the splash from the [InkWell] animates
/// with the [child].
///
/// The [onTap] parameter **must** either push or pop a route from the
/// stack, or do so indirectly, otherwise the animation will not work.
/// This can be done by calling [Navigator.push] or [Navigator.pop] amonng
/// other methods.
///
/// The [id] parameter must be the same for the two [PhotoHero] objects
/// which will drive the animation. If the [id] is outside of the range of
/// [ProductsRepository.allProducts], it will throw an error.
class PhotoHero extends StatelessWidget {
  final int id;
  final VoidCallback onTap;
  final double width;
  final Widget child;

  const PhotoHero({
    @required this.id,
    @required this.onTap,
    @required this.width,
    @required this.child,
  })  : assert(id != null &&
            id >= 0 &&
            id < ProductsRepository.allProducts.length),
        assert(width >= 0),
        assert(width != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: id,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
