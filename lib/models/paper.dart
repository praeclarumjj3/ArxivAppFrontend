// To parse this JSON data, do
//
//     final paper = paperFromJson(jsonString);

import 'dart:convert';

Paper paperFromJson(String str) => Paper.fromJson(json.decode(str));

String paperToJson(Paper data) => json.encode(data.toJson());

class Paper {
  Paper({
    this.id,
    this.title,
    this.authors,
    this.summary,
    this.comment,
    this.subjectClassification,
    this.category,
    this.arxivId,
    this.htmlUrl,
    this.pdfUrl,
    this.datetimePaperPublished,
    this.datetimePaperUpdated,
  });

  int id;
  String title;
  String authors;
  String summary;
  String comment;
  String subjectClassification;
  String category;
  String arxivId;
  String htmlUrl;
  String pdfUrl;
  DateTime datetimePaperPublished;
  DateTime datetimePaperUpdated;

  factory Paper.fromJson(Map<String, dynamic> json) => Paper(
        id: json['id'],
        title: json['title'],
        authors: json['authors'],
        summary: json['summary'],
        comment: json['comment'],
        subjectClassification: json['subject_classification'],
        category: json['category'],
        arxivId: json['arxiv_id'],
        htmlUrl: json['html_url'],
        pdfUrl: json['pdf_url'],
        datetimePaperPublished:
            DateTime.parse(json['datetime_paper_published']),
        datetimePaperUpdated: DateTime.parse(json['datetime_paper_updated']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'authors': authors,
        'summary': summary,
        'comment': comment,
        'subject_classification': subjectClassification,
        'category': category,
        'arxiv_id': arxivId,
        'html_url': htmlUrl,
        'pdf_url': pdfUrl,
        'datetime_paper_published': datetimePaperPublished.toIso8601String(),
        'datetime_paper_updated': datetimePaperUpdated.toIso8601String(),
      };
}
