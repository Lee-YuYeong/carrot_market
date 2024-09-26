import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


class PostContentWidget extends StatelessWidget {
  final SimpleProductPost simpleProductPost;
  final ProductPost? productPost;
  const PostContentWidget({super.key, required this.simpleProductPost, this.productPost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            simpleProductPost.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Height(20),
          Text(
            timeago.format(simpleProductPost.createdTime, locale: context.locale.languageCode),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
          ),

          if (productPost == null)
          const Center(child: CircularProgressIndicator())
          else 
          Text(
            productPost!.content
          )
        ],
      ),
    );
  }
}