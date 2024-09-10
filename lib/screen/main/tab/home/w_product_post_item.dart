import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductPostItem extends StatelessWidget {
  final ProductPost post;

  const ProductPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: post.product.images[0],
        ),
        Expanded(
          child: Column(
            children: [
              Text(post.content)
            ],
          )
        )
      ],
    );
  }
}