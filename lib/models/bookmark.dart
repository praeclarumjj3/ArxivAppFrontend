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
    this.summary,
    this.comment,
    this.subjectClassification,
    this.category,
    this.arxivId,
    this.htmlUrl,
    this.pdfUrl,
    this.datetimePaperPublished,
    this.datetimePaperUpdated,
    this.mediaUrl,
  });

  int id;
  DateTime datetimeCreated;
  DateTime datetimeModified;
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
  String mediaUrl;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json['id'],
        datetimeCreated: DateTime.parse(json['datetime_created']),
        datetimeModified: DateTime.parse(json['datetime_modified']),
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
        mediaUrl: json['media_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'datetime_created': datetimeCreated.toIso8601String(),
        'datetime_modified': datetimeModified.toIso8601String(),
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
        'media_url': mediaUrl,
      };
}
