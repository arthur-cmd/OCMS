// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey.shade500,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      color: Colors.grey,
    ),
  );
}
