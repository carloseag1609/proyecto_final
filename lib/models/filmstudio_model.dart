class FilmStudio {
  FilmStudio({
    this.id,
    required this.name,
    required this.logo,
  });

  int? id;
  String name;
  String logo;

  factory FilmStudio.fromJson(Map<String, dynamic> json) => FilmStudio(
        id: json['id'],
        name: json['name'],
        logo: json['logo'],
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "logo": logo};
}
