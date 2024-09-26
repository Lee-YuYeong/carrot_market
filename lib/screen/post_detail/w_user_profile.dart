import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/entity/user/vo_address.dart';
import 'package:fast_app_base/entity/user/vo_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserProfileWidget extends StatelessWidget {
  final User user;
  final Address address;
  const UserProfileWidget(this.user, {super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          ClipOval(child: CachedNetworkImage(imageUrl: user.profileUrl, width: 60,)),
          const Width(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.nickname),
                const Height(10),
                Text(address.simpleAddress),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${user.temperature} C', style: TextStyle(color: Colors.green),),
                      const SizedBox(
                        width: 60,
                        child: LinearProgressIndicator(
                          value: 0.3,
                          color: Colors.green,
                        )
                      )
                    ],
                  ),
                  Image.asset('$basePath/detail/smile.png', width: 30)
                ],
              ),
              Text(
                "매너 온도",
                style: TextStyle(),
              )
            ],
          )
      
        ],
      ),
    );
  }
}