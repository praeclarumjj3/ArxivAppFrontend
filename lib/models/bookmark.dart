// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<Bookmark> bookmarkFromJson(String str) =>
    List<Bookmark>.from(json.decode(str).map((x) => Bookmark.fromJson(x)));

String bookmarkToJson(List<Bookmark> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bookmark {
  Bookmark({
    this.id,
    this.datetimeCreated,
    this.datetimeModified,
    this.title,
    this.authors,
    this.category,
    this.arxivId,
    this.htmlUrl,
    this.pdfUrl,
    this.mediaUrl,
  });

  int id;
  String datetimeCreated;
  String datetimeModified;
  String title;
  String authors;
  String category;
  String arxivId;
  String htmlUrl;
  String pdfUrl;
  String mediaUrl;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json['id'],
        datetimeCreated: json['datetime_created'],
        datetimeModified: json['datetime_modified'],
        title: json['title'],
        authors: json['authors'],
        category: json['category'],
        arxivId: json['arxiv_id'],
        htmlUrl: json['html_url'],
        pdfUrl: json['pdf_url'],
        mediaUrl: json['media_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'datetime_created': datetimeCreated,
        'datetime_modified': datetimeModified,
        'title': title,
        'authors': authors,
        'category': category,
        'arxiv_id': arxivId,
        'html_url': htmlUrl,
        'pdf_url': pdfUrl,
        'media_url': mediaUrl,
      };
}
