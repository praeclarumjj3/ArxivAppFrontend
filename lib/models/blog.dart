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
    this.votes,
  });

  int id;
  String title;
  String body;
  int author;
  int votes;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      author: json['author'],
      votes: json['votes']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'author': author,
        'votes': votes
      };
}
