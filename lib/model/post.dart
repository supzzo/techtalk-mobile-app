import 'package:html_unescape/html_unescape.dart';
import 'package:html/parser.dart';

class Post {
  int id;
  String title;
  String slug;
  String excerpt;
  String content;
  String link;
  String type;
  String thumbUrl;
  DateTime date;
  String author;
  List<int> tags;

  Post({
    this.id,
    this.title,
    this.slug,
    this.excerpt,
    this.content,
    this.link,
    this.type,
    this.thumbUrl,
    this.date,
    this.author,
    this.tags,
  });

  static Post fromMap(Map<String, dynamic> map) {
    final HtmlUnescape _unescape = HtmlUnescape();

    final String _title = _unescape.convert(map['title']['rendered']);
    final String _excerpt = parse(_unescape.convert(map['excerpt']['rendered']))
        .documentElement
        .text
        .trim();
    final String _content = map['content']['rendered'];
    final List<int> _tags =
        (map['tags'] as List).map((tag) => int.parse(tag.toString())).toList();

    return Post(
      id: map['id'],
      title: _title,
      slug: map['slug'],
      excerpt: _excerpt,
      content: _content,
      link: map['link'],
      type: map['type'] ?? 'post',
      thumbUrl: map['_embedded']['wp:featuredmedia'][0]['source_url'],
      date: DateTime.parse(map['date']) ?? DateTime.now(),
      author: map['_embedded']['author'][0]['name'],
      tags: _tags,
    );
  }
}
