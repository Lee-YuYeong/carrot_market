import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:flutter/material.dart';

class ProductPostItem extends StatelessWidget {
  final ProductPost post;

  const ProductPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(imageUrl: post.product.images[0], width: 150)),
          Expanded(
            child: Column(
              children: [
                Text(post.content)
              ],
            )
          )
        ],
      ),
    );
  }
}