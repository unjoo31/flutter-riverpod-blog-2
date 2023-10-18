import 'package:flutter/material.dart';
import 'package:flutter_blog/data/dto/post_request.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/data/store/session_store.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/post.dart';

class PostListModel {
  List<Post> posts;
  PostListModel(this.posts);
}

class PostListViewModel extends StateNotifier<PostListModel?> {
  PostListViewModel(super._state, this.ref);

  final mContext = navigatorKey.currentContext;
  Ref ref;

  Future<void> notifyInit() async {
    SessionStore sessionStore = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPostList(sessionStore.jwt!);
    state = PostListModel(responseDTO.data);
  }

  Future<void> notifyAdd(PostSaveReqDTO dto) async {
    SessionStore sessionStore = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPost(sessionStore.jwt!, dto);

    if (responseDTO.code == 1) {
      Post newPost = responseDTO.data as Post;
      List<Post> newPosts = [newPost, ...state!.posts];
      state = PostListModel(newPosts);
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
          SnackBar(content: Text("게시글 작성 실패:${responseDTO.msg}")));
    }
  }
}

final postListProvider =
    StateNotifierProvider.autoDispose<PostListViewModel, PostListModel?>((ref) {
  return PostListViewModel(null, ref)..notifyInit();
});
