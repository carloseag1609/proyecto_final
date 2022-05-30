class Movie {
  Movie({
    this.id,
    required this.title,
    required this.originalLanguage,
    required this.poster,
    required this.release,
    required this.overview,
    required this.filmStudioId,
    required this.name,
    required this.logo,
  });

  int? id;
  String title;
  String originalLanguage;
  String poster;
  String overview;
  String release;
  int filmStudioId;
  String? name = "";
  String? logo = "";

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        title: json['title'],
        originalLanguage: json['originalLanguage'],
        filmStudioId: json['filmStudioId'],
        poster: json['poster'],
        overview: json['overview'],
        release: json['release'],
        name: json['name'],
        logo: json['logo'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "originalLanguage": originalLanguage,
        "filmStudioId": filmStudioId,
        "poster": poster,
        "overview": overview,
        "release": release,
        "name": name,
        "logo": logo,
      };
}
