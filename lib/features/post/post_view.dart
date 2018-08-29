import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:techtalk_mobile_app/model/category.dart';
import 'package:techtalk_mobile_app/model/post.dart';
import 'package:techtalk_mobile_app/features/post/post_contract.dart';
import 'package:techtalk_mobile_app/features/post/post_presenter.dart';

class PostView extends StatefulWidget {
  final Post post;
  final Category category;

  PostView({
    this.post,
    this.category,
  });

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with PostContract {
  PostPresenter _presenter;

  bool _isLoading = true;

  Post _post;

  _PostViewState() {
    _presenter = PostPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    _presenter.loadPost(widget.post.id);
  }

  @override
  void onSuccess(Post post) {
    setState(() {
      _isLoading = false;
      _post = post;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _post.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.body1.copyWith(
                              color: Theme.of(context).textTheme.caption.color,
                            ),
                        child: Row(
                          children: <Widget>[
                            Text(_post.author),
                            SizedBox(width: 4.0),
                            Text('•'),
                            SizedBox(width: 4.0),
                            Text(
                              DateFormat.yMMMd('vi').format(_post.date),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: _post.thumbUrl,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                Html(
                  padding: EdgeInsets.all(16.0),
                  data: _post.content,
                ),
              ],
            ),
    );
  }
}
