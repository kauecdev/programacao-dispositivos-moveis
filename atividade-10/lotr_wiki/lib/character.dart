class Character {
  late String id;
  late String name;
  late String race;
  late String realm;
  late String gender;
  late String birth;
  late String death;
  late String wikiUrl;

  Character({
      required this.id,
      required this.name,
      required this.race,
      required this.realm,
      required this.gender,
      required this.birth,
      required this.death,
      required this.wikiUrl
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['_id'],
      name: json['name'],
      race: json['race'] == "" ? "Unknown" : json['race'],
      realm: json['realm'] == "" ? "Unknown": json['realm'],
      gender: json['gender'] == "" ? "Unknown" : json['gender'],
      birth: json['birth'] == "" ? "Unknown" : json['birth'],
      death: json['death'] == "" ? "Unknown" : json['death'],
      wikiUrl: json['wikiUrl'] == "" ? "N/A" : json['wikiUrl'],
    );
  }
}