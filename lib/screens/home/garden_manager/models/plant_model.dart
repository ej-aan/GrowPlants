class Plant {
  String id;
  String name;
  String type;
  String size;
  String light;
  String water;
  String soil;
  String plantingDate;
  String status;
  String? notes;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.light,
    required this.water,
    required this.soil,
    required this.plantingDate,
    required this.status,
    this.notes,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      light: json['light'],
      water: json['water'],
      soil: json['soil'],
      plantingDate: json['plantingDate'],
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'size': size,
      'light': light,
      'water': water,
      'soil': soil,
      'plantingDate': plantingDate,
      'status': status,
      'notes': notes,
    };
  }
}
