import 'dart:async';

import 'package:doglife/pages/post.dart';

class Controller {
  StreamController<List<Post>> controller = StreamController<List<Post>>();
  List<Post> posts = List<Post>();

  Stream<List<Post>> get output => controller.stream;
  StreamSink<List<Post>> get input => controller.sink;

  void populate() {
    posts.add(Post(id: 1, text: "texto 1", liked: true));
    posts.add(Post(id: 2, text: "texto 2", liked: false));
    posts.add(Post(id: 3, text: "texto 3", liked: false));
    input.add(posts);
  }

  void like(int id) {
    int index = posts.indexWhere((item) => item.id == id);
    posts[index].liked = !posts[index].liked;
    input.add(posts);
  }

  void dispose() {
    controller.close();
  }
}
