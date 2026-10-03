import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class PreviewCardImage extends StatelessWidget {
  final String url;
  final AssetImage errorImage;
  final double? hieght;
  final double? width;
  final BoxFit fit;

  const PreviewCardImage({
    Key? key,
    required this.url,
    required this.errorImage,
    this.hieght,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: CachedNetworkImageProvider(url),
      errorBuilder: OctoError.icon(),
      fit: fit,
      height: hieght,
      width: width,
    );
  }
}
