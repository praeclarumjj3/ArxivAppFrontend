// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  Blog({
    this.id,
    this.title,
    this.body,
    this.author,
    this.upvotes,
    this.downvotes,
  });

  int id;
  String title;
  String body;
  int author;
  int upvotes;
  int downvotes;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        author: json['author'],
        upvotes: json['upvotes'],
        downvotes: json['downvotes'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'author': author,
        'upvotes': upvotes,
        'downvotes': downvotes,
      };
}
