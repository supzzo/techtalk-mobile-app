import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:techtalk_mobile_app/features/home/home_contract.dart';
import 'package:techtalk_mobile_app/features/home/home_presenter.dart';
import 'package:techtalk_mobile_app/features/post/post_view.dart';
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
          title: Text('TechTalk'),
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
  HomePresenter _presenter;

  bool _isLoading = true;

  List<Post> _posts = <Post>[];

  _PostListState() {
    _presenter = HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();

    _presenter.loadPosts(widget.category.id);
  }

  @override
  void onSuccess(List<Post> posts) {
    setState(() {
      _isLoading = false;
      _posts = posts;
    });
  }

  @override
  void onError(error) {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CupertinoActivityIndicator()
        : ListView.builder(
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

class PostItem extends StatelessWidget {
  final Post post;
  final Category category;

  PostItem({
    this.post,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        post.excerpt,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Theme.of(context).textTheme.caption.color),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CupertinoActivityIndicator(),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: post.thumbUrl,
                      width: 90.0,
                      height: 90.0,
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.author),
                      Text(
                        DateFormat.yMMMd('vi').format(post.date),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.bookmark_border),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostView(post: post, category: category),
          ),
        );
      },
    );
  }
}
