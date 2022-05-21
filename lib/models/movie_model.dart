import 'dart:convert';

class Movie {
  Movie({
    this.id,
    required this.title,
    required this.originalLanguage,
    required this.poster,
    required this.actors,
    required this.releaseDate,
    required this.genres,
    required this.duration,
  });

  int? id;
  String title;
  String originalLanguage;
  String poster;
  DateTime releaseDate;
  List<String> actors;
  List<String> genres;
  String duration;
}
