import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:fast_app_base/entity/product/vo_product.dart';
import 'package:fast_app_base/screen/post_detail/provider/product_post_provider.dart';
import 'package:fast_app_base/screen/post_detail/w_post_content.dart';
import 'package:fast_app_base/screen/post_detail/w_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostDetailScreen extends ConsumerWidget {
  final SimpleProductPost? simpleProductPost;
  final int id;
  const PostDetailScreen(this.id, {super.key, this.simpleProductPost});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productPost = ref.watch(ProductPostProvider(id));
    return productPost.when(
      data: (data) => _PostDetail(data.simpleProductPost, productPost: data), 
      error: (error, trace) => Text("에러 발생"), 
      loading: () => simpleProductPost != null ? _PostDetail(simpleProductPost!) : Center(child: CircularProgressIndicator())
    );
  }
}

class _PostDetail extends HookWidget {
  final SimpleProductPost simpleProductPost;
  final ProductPost? productPost;
  const _PostDetail(this.simpleProductPost, {this.productPost, super.key});

  @override
  Widget build(BuildContext context) {

    final pageController = usePageController();

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding:const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300, // context.deviceHeight
                    width: 610, // context.deviceWidth
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageController,
                          children: simpleProductPost.product.images.map((url) {
                            return CachedNetworkImage(imageUrl: url, fit: BoxFit.fill,);
                          }).toList(),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: simpleProductPost.product.images.length,
                            effect: const JumpingDotEffect(
                              verticalOffset: 10,
                              dotColor: Colors.white54,
                              activeDotColor: Colors.black45,
                            ),
                            onDotClicked: ((index) {
            
                            }),
                          ),
                        ),
                      ],
                    ),  
                  ),
                  
                  UserProfileWidget(simpleProductPost.product.user, address: simpleProductPost.address,),
                  PostContentWidget(simpleProductPost: simpleProductPost, productPost: productPost),
                ],
              ),
            ),
          ),

          
      
          SizedBox(
            height: 60 + context.statusBarHeight,
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(onPressed: () {Nav.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.white,)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white,))
            
              ],
            ),
          ),
      
          Align(
            alignment: Alignment.bottomCenter,
            child: PostDetailBottomMenu(simpleProductPost.product)
          )
        ],
      ),
    );
  }
}

class PostDetailBottomMenu extends StatelessWidget {
  final Product product;
  const PostDetailBottomMenu(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          const Line(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Image.asset('$basePath/detail/heart_on.png', height: 25,),
                const Width(10),
                const Expanded(child: Text("가격 제안하기", style: TextStyle(color: Colors.orange))),
                RoundButton(text: "채팅하기", onTap: () {}, bgColor: Colors.orange, borderRadius: 7,)
            
              ],
            ),
          )

        ],
      ),
    );
  }
}