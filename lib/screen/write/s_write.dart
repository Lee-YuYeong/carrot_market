import 'dart:io';

import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/entity/dummies.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:fast_app_base/entity/product/product_status.dart';
import 'package:fast_app_base/entity/product/vo_product.dart';
import 'package:fast_app_base/entity/user/vo_address.dart';
import 'package:fast_app_base/entity/user/vo_user.dart';
import 'package:fast_app_base/screen/main/tab/home/provider/post_provider.dart';
import 'package:fast_app_base/screen/post_detail/s_post_detail.dart';
import 'package:fast_app_base/screen/write/d_select_image_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> with KeyboardDetector{

  final List<String> imageList = [];
  
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    titleController.addListener(() {
      setState(() {});
    });
    priceController.addListener(() {
      setState(() {});
    });
    descriptionController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 물건 팔기', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          Tap(
            onTap: () {
              
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('임시 저장'),
            )
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageSelectWidget(
              imageList, 
              onTap: () async {
                final selectedSource = await SelectImagesourceDialog().show();

                if (selectedSource == null) {
                  return;
                }
                final file = await ImagePicker().pickImage(source: selectedSource);
                if (file == null) {
                  return;
                }
                setState(() {
                  imageList.add(file.path);                  
                });
              },

              onTapDeleteImage: (imagePath) {
                setState(() {
                imageList.remove(imagePath);                  
                });
              },
            ),
            const Height(30),
            _TitleEditor(titleController),
            const Height(30),
            _PriceEditor(priceController),
            const Height(30),
            _DescEditor(descriptionController),
          ],
        ),
      ),

      bottomSheet: isKeyboardOn ? null : RoundButton(
        text: isLoading ? '저장 중' : '작성 완료',
        rightWidget: isLoading ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator()) : null,
        isEnabled: isValid,
        isFullWidth: true,
        borderRadius: 6,
        onTap: () {
          final title = titleController.text;
          final price = int.parse(priceController.text);
          final desc = descriptionController.text;
          setState(() {
            isLoading = true;
          });

          final list = ref.read(PostProvider);
          final simpleProductPost = SimpleProductPost(7, user3, Product(user3, title, price, ProductStatus.normal, imageList), title, Address("서울 특별시 ", "역삼동"), 0, 0, DateTime.now());
          ref.read(PostProvider.notifier).state 
          = List.of(list)..add(simpleProductPost);

          Nav.pop(context);
          Nav.push(PostDetailScreen(simpleProductPost.id, simpleProductPost: simpleProductPost,));
        },
      ),
    );
  }

  bool get isValid => isNotBlank(titleController.text) && isNotBlank(priceController.text) && isNotBlank(descriptionController.text);
}

class _ImageSelectWidget extends StatelessWidget{
  final List<String> imageList;
  final VoidCallback onTap;
  final void Function(String path) onTapDeleteImage;

  const _ImageSelectWidget(this.imageList, {super.key, required this.onTap, required this.onTapDeleteImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
    
        child: Row(
          children: [
            Tap(
              onTap: onTap,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt),
                    const Height(10),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: imageList.length.toString()),
                          const TextSpan(text: '/10'),
                        ]
                      )
                    )
                  ],
                ),
              ),
            ),

            ...imageList.map((e) => Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.file(File(e), fit: BoxFit.fill)),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(icon: Icon(Icons.close), onPressed: () => onTapDeleteImage(e)),
                  ),
                )

              ],
            ),
            )
          ],
        ),
      ),
    );
  }

}

class _TitleEditor extends StatelessWidget {
  final TextEditingController controller;

  const _TitleEditor(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '제목'
        ), 
        const Height(5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '제목',
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(6)
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(6)
            )
          ),
        )
      ],
    );
    
  }
}

class _PriceEditor extends StatefulWidget {
  final TextEditingController controller;

  const _PriceEditor(this.controller, {super.key});

  @override
  State<_PriceEditor> createState() => _PriceEditorState();
}

class _PriceEditorState extends State<_PriceEditor> {

  final priceNode = FocusNode();

  bool isDonatedMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '거래 방식'
        ), 
        const Height(5),

        Row(
          children: [
            RoundButton(
              text: '판매하기',
              textColor: isDonatedMode ? Colors.white : Colors.black,
              bgColor: isDonatedMode ? Colors.transparent : Colors.white,
              borderColor: Colors.white,
              onTap: () {
                widget.controller.clear();
                setState(() {
                  isDonatedMode = false;
                });
                delay(() {
                AppKeyboardUtil.show(context, priceNode);
                });
              },
            ),
            RoundButton(
              text: '나눔하기',
              textColor: !isDonatedMode ? Colors.white : Colors.black,
              bgColor: !isDonatedMode ? Colors.transparent : Colors.white,
              borderColor: Colors.white,
              onTap: () {
                widget.controller.text = "0";
                setState(() {
                  isDonatedMode = true;
                });
              },
            )
          ],
        ),
        const Height(10),

        TextField(
          controller: widget.controller,
          enabled: !isDonatedMode,
          focusNode: primaryFocus,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '가격을 입력해주세요.',
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(6)
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(6)
            )
          ),
        )
      ],
    );
    
  }
}

class _DescEditor extends StatelessWidget {
  final TextEditingController controller;

  const _DescEditor(this.controller, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '자세한 설명'
        ), 
        const Height(5),
        TextField(
          controller: controller,
          maxLines: 7,
          decoration: InputDecoration(
            hintText: '자세한 설명을 입력해주세요\n자세한 설명 설명',
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(6)
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(6)
            )
          ),
        )
      ],
    );
  }
}