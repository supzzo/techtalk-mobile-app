import 'package:html_unescape/html_unescape.dart';

class Category {
  int id;
  String name;
  String slug;
  String description;
  String link;
  int parent;

  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.link,
    this.parent,
  });

  static Category fromMap(Map<String, dynamic> map) {
    final HtmlUnescape _unescape = HtmlUnescape();

    final String _name = _unescape.convert(map['name']);

    return Category(
      id: map['id'],
      name: _name,
      slug: map['slug'],
      description: map['description'],
      link: map['link'],
      parent: map['parent'],
    );
  }
}
