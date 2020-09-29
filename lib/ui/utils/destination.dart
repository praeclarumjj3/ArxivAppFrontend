import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Papers Hub', Icons.search),
  Destination('Bookmarks', Icons.bookmark),
  Destination('Downloads', Icons.file_download),
  Destination('Forum', Icons.forum),
];
