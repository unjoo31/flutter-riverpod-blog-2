import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dto/post_request.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:logger/logger.dart';

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
      return ResponseDTO(-1, "게시글 목록 불러오기 실패", null);
    }
  }

  Future<ResponseDTO> savePost(String jwt, PostSaveReqDTO dto) async {
    try {
      final response = await dio.post("/post",
          data: dto.toJson(),
          options: Options(headers: {"Authorization": "${jwt}"}));
      Logger().d(response.data);
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      Logger().d(responseDTO.data);
      Post post = Post.fromJson(responseDTO.data);
      responseDTO.data = post;

      return responseDTO;
    } catch (e) {
      return ResponseDTO(-1, "게시글 작성 실패", null);
    }
  }

  Future<ResponseDTO> fetchPost(String jwt, int id) async {
    try {
      Response response = await dio.get("/post/${id}",
          options: Options(headers: {"Authorization": "$jwt"}));
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(-1, "게시글 한건 불러오기 실패", null);
    }
  }
}
