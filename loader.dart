import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loader extends StatelessWidget {
  Loader({super.key, Size? size, double? borderRadius}) {
    _size = size ?? Size(0, 0);
    _borderRadius = borderRadius ?? 0.0;
  }

  late final Size _size;
  late final double _borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Container(
        height: _size.height,
        width: _size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),
    );
  }

  static Loader square(double size) {
    return Loader(size: Size.square(size));
  }

  static Loader circular(double size) {
    return Loader(size: Size.square(size), borderRadius: size);
  }

  static Loader rounded(Size size) {
    return Loader(size: size, borderRadius: 6.0);
  }
}
