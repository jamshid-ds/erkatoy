import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageView extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  // final AnimationController controller;
  final double borderRadius;

  const CachedImageView({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    // required this.controller,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: /*fillMaxWidth(context)*/ width,
          height: /*fillMaxHeight(context) * 0.156*/ height,
          fit: BoxFit.cover,
          fadeInCurve: Curves.easeInToLinear,
          fadeOutCurve: Curves.linearToEaseOut,
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     Container(
          //       decoration: BoxDecoration(
          //         gradient: shimmerEffect(
          //           context,
          //           controller,
          //           /*AnimationController(
          //             vsync: this,
          //             duration: const Duration(seconds: 1),
          //           )..repeat(reverse: true),*/
          //         ),
          //       ),
          //     ),
        ),
      );
}
