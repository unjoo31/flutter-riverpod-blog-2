import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestParam {
  int? postDetailId;

  RequestParam({this.postDetailId});
}

class ParamStore extends RequestParam {
  final mContext = navigatorKey.currentContext;
}

final paramProvider = Provider<ParamStore>((ref) {
  return ParamStore();
});
