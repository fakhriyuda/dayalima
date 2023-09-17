import 'package:dayagram/core/client/client.dart';
import 'package:dayagram/core/client/result.dart';
import 'package:dayagram/features/home/data/model/post.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  static Future getListPosts({int? page, int? size}) async {
    var endPoint =
        "https://dlabstech-test.irufano.com/api/post?page=$page&size=$size";
    Response<String> response = await Client().dio.get(endPoint);
    return Result(ResultType.Success, "Berhasil Get List Posts",
        data: postFromJson(response.data!));
  }
}
