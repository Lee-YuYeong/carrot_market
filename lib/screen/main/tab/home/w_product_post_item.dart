import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:fast_app_base/screen/post_detail/s_post_detail.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductPostItem extends StatelessWidget {
  final SimpleProductPost post;

  const ProductPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () {
        Nav.push(PostDetailScreen(post.id, simpleProductPost: post));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(imageUrl: post.product.images[0], width: 150),
                ),
                const Width(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      Row(
                        children: [
                          Text(post.address.simpleAddress, style: const TextStyle(fontSize: 14, color: Colors.grey),),
                          Text(timeago.format(post.createdTime, locale: context.locale.languageCode), style:const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    Text("${post.product.price}원")
                    ],
                  )
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("$basePath/home/post_comment.png"),
                  Text(post.chatCount.toString()),
                  Image.asset("$basePath/home/post_heart_off.png"),
                  Text(post.likeCount.toString()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}