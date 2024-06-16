import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;

  const AppImage({
    required this.imageUrl,
    this.height = 150.0,
    this.width = double.infinity,
    this.borderRadius = 5.0,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: height,
            width: width,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
        fit: fit,
        height: height,
        width: width,
      ),
    );
  }
}
