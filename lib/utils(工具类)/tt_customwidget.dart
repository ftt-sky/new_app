import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 加载网络图片
Widget conFigNetWorkImage(
    String url, double width, double height, BorderRadius borderRadius) {
  return ClipRRect(
    child: CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: BoxFit.fill,
      placeholder: (context, url) {
        return ProgressWidget();
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
      fadeOutDuration: const Duration(seconds: 1),
      fadeInDuration: const Duration(seconds: 1),
    ),
  );
}

/// 进度条
class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
