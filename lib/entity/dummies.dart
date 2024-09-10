import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:fast_app_base/entity/product/product_status.dart';
import 'package:fast_app_base/entity/product/vo_product.dart';
import 'package:fast_app_base/entity/user/vo_address.dart';
import 'package:fast_app_base/entity/user/vo_user.dart';

String picsum(int id) {
  return 'https://picsum.photos/id/$id/200/200';
}

final user1 = User(id: 1, nickname: '홍길동', profileUrl: picsum(1010), temperature: 36.5);
final user2 = User(id: 1, nickname: '바다', profileUrl: picsum(900), temperature: 40.3);
final user3 = User(id: 1, nickname: '파토', profileUrl: picsum(700), temperature: 60.8);

final product1 = Product(user1, "아이폰", 700000, "깨끗하게 썼어요" "아껴서 사용했습니다", ProductStatus.normal, [picsum(100), picsum(101), picsum(102)]);
final product2 = Product(user2, "스마트 티비", 2000000, "화질 좋아요" "아껴서 사용했습니다", ProductStatus.normal, [picsum(500), picsum(501), picsum(502), picsum(503)]);
final product3 = Product(user3, "카메라", 300000, "사진 잘 찍혀요" "아껴서 사용했습니다", ProductStatus.normal, [picsum(300), picsum(301), picsum(302)]);


final post1 = ProductPost(product1.user, product1, "글의 내용입니다", const Address("서울 특별시 주소", "구의동"), 3, 10, DateTime.now().subtract(30.minutes));
final post2 = ProductPost(product2.user, product2, "글의 내용입니다", const Address("광주 광역시 주소", "동명동"), 20, 30, DateTime.now().subtract(55.minutes));
final post3 = ProductPost(product3.user, product3, "글의 내용입니다", const Address("서울 특별시 주소", "한강진동"), 5, 1, DateTime.now().subtract(5.hours));

final postList = [post1, post2, post3, post1, post2, post3];
