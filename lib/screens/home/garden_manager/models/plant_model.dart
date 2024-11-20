class Plant {
  final String id;
  String name;
  String type;
  String? notes;
  DateTime dateAdded;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    this.notes,
    required this.dateAdded,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'notes': notes,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      notes: json['notes'],
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }
}


