// To parse this JSON data, do
//
//     final paper = paperFromJson(jsonString);

import 'dart:convert';

String paperToJson(Paper data) => json.encode(data.toJson());

List<Paper> paperFromJson(String str) =>
    List<Paper>.from(json.decode(str).map((x) => Paper.fromJson(x)));

class Paper {
  Paper({
    this.id,
    this.title,
    this.authors,
    this.category,
    this.arxivId,
    this.htmlUrl,
    this.pdfUrl,
  });

  int id;
  String title;
  String authors;
  String category;
  String arxivId;
  String htmlUrl;
  String pdfUrl;

  factory Paper.fromJson(Map<String, dynamic> json) => Paper(
        id: json['id'],
        title: json['title'],
        authors: json['authors'],
        category: json['category'],
        arxivId: json['arxiv_id'],
        htmlUrl: json['html_url'],
        pdfUrl: json['pdf_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'authors': authors,
        'category': category,
        'arxiv_id': arxivId,
        'html_url': htmlUrl,
        'pdf_url': pdfUrl,
      };
}
