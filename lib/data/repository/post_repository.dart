import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/model/post.dart';

import '../dto/response_dto.dart';

class PostRepository {
  Future<ResponseDTO> fetchPostList(String jwt) async {
    try {
      final response = await dio.get("/post",
          options: Options(headers: {"Authorization": "${jwt}"}));
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      List<dynamic> mapList = responseDTO.data as List<dynamic>;
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
      responseDTO.data = postList;
      return responseDTO;
    } catch (e) {
      return ResponseDTO(-1, "로그인후 사용 가능합니다", null);
    }
  }
}
