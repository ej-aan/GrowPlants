class Plant {
  String id;
  String name;
  String type;
  String size;
  String light;
  String water;
  String soil;
  DateTime plantingDate;
  String status;
  String? notes;
  String? image;

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
    this.image,
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
      plantingDate: DateTime.parse(json['plantingDate']),
      status: json['status'],
      notes: json['notes'],
      image: json['image'],
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
      'plantingDate': plantingDate.toIso8601String(),
      'status': status,
      'notes': notes,
      'image': image,
    };
  }

  Plant copyWith({
    String? id,
    String? name,
    String? type,
    String? size,
    String? light,
    String? water,
    String? soil,
    DateTime? plantingDate,
    String? status,
    String? notes,
    String? image,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      size: size ?? this.size,
      light: light ?? this.light,
      water: water ?? this.water,
      soil: soil ?? this.soil,
      plantingDate: plantingDate ?? this.plantingDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      image: image ?? this.image,
    );
  }
}
