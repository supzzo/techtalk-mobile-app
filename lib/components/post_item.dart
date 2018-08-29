import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techtalk_mobile_app/features/post/post_view.dart';

import 'package:techtalk_mobile_app/model/category.dart';
import 'package:techtalk_mobile_app/model/post.dart';
import 'package:transparent_image/transparent_image.dart';

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
