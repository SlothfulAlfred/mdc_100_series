import 'package:Shrine/model/products_repository.dart';
import 'package:flutter/material.dart';

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
