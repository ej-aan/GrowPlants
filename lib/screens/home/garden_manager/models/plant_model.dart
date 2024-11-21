class Plant {
  final String id;
  String name;
  String type;

  Plant({
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}


