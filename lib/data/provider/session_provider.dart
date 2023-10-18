// import 'package:flutter/material.dart';
// import 'package:flutter_blog/_core/constants/http.dart';
// import 'package:flutter_blog/_core/constants/move.dart';
// import 'package:flutter_blog/data/dto/response_dto.dart';
// import 'package:flutter_blog/data/dto/user_request.dart';
// import 'package:flutter_blog/data/model/user.dart';
// import 'package:flutter_blog/data/repository/user_repository.dart';
// import 'package:flutter_blog/main.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class SessionUser {
//   final mContext = navigatorKey.currentContext;
//
//   User? user;
//   String? jwt;
//   bool isLogin;
//
//   SessionUser({this.user, this.jwt, this.isLogin = false});
//
//   Future<void> join(JoinReqDTO joinReqDTO) async {
//     ResponseDTO responseDTO = await UserRepository().fetchJoin(joinReqDTO);
//     if (responseDTO.code == 1) {
//       Navigator.pushNamed(mContext!, Move.loginPage);
//     } else {
//       ScaffoldMessenger.of(mContext!)
//           .showSnackBar(SnackBar(content: Text(responseDTO.msg)));
//     }
//   }
//
//   Future<void> login(LoginReqDTO loginReqDTO) async {
//     ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);
//     if (responseDTO.code == 1) {
//       this.user = responseDTO.data as User;
//       this.jwt = responseDTO.token;
//       this.isLogin = true;
//       await secureStorage.write(key: "jwt", value: responseDTO.token);
//       Navigator.pushNamed(mContext!, Move.postListPage);
//     } else {
//       ScaffoldMessenger.of(mContext!)
//           .showSnackBar(SnackBar(content: Text(responseDTO.msg)));
//     }
//   }
//
//   Future<void> logout() async {
//     this.jwt = null;
//     this.isLogin = false;
//     this.user = null;
//     await secureStorage.delete(key: "jwt");
//     Navigator.pushNamed(mContext!, Move.loginPage);
//   }
// }
//
// final sessionProvider = Provider<SessionUser>((ref) {
//   return SessionUser();
// });
