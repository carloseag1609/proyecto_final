class Actor {
  Actor({
    this.id,
    required this.name,
    required this.alias,
  });

  int? id;
  String name;
  String alias;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        id: json['id'],
        name: json['name'],
        alias: json['alias'],
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "alias": alias};
}
