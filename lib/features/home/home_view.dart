import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:techtalk_mobile_app/components/post_item.dart';
import 'package:techtalk_mobile_app/features/home/home_contract.dart';
import 'package:techtalk_mobile_app/features/home/home_presenter.dart';
import 'package:techtalk_mobile_app/model/category.dart';
import 'package:techtalk_mobile_app/model/post.dart';

class HomeView extends StatelessWidget {
  final List<Category> categories;

  HomeView(this.categories);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Bài viết mới',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            labelStyle: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: FontWeight.bold),
            tabs: categories
                .map((Category category) => Tab(text: category.name))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: categories
              .map((Category category) => PostList(category))
              .toList(),
        ),
      ),
    );
  }
}

class PostList extends StatefulWidget {
  final Category category;

  PostList(this.category);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList>
    with HomeContract, AutomaticKeepAliveClientMixin {
  ScrollController _controller;

  HomePresenter _presenter;

  int _page = 1;

  bool _isLoading = true;

  List<Post> _posts = <Post>[];

  _PostListState() {
    _controller = ScrollController();

    _presenter = HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = 200.0;
      if (maxScroll - currentScroll <= delta) {
        _presenter.loadPosts(widget.category.id, ++_page);
      }
    });

    _presenter.loadPosts(widget.category.id, _page);
  }

  @override
  void onSuccess(List<Post> posts) {
    setState(() {
      _isLoading = false;
      _posts.addAll(posts);
    });
  }

  @override
  void onError(error) {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CupertinoActivityIndicator()
        : ListView.builder(
            controller: _controller,
            itemCount: _posts.length,
            itemBuilder: (_, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    height: .0,
                    color: Colors.grey[600],
                  ),
                  PostItem(
                    category: widget.category,
                    post: _posts[index],
                  ),
                ],
              );
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}
