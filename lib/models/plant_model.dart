class Plant {
  String id;
  String name;
  String type;
  String size;
  String lightRequirement;
  String waterRequirement;
  String soilRequirement;
  String status;
  DateTime plantingDate;
  String? notes; // Add this field if missing
  String? image; // File path or URL to the image

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.lightRequirement,
    required this.waterRequirement,
    required this.soilRequirement,
    required this.status,
    required this.plantingDate,
    this.notes, // Ensure this is defined
    this.image,
  });

  // JSON serialization methods
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      lightRequirement: json['lightRequirement'],
      waterRequirement: json['waterRequirement'],
      soilRequirement: json['soilRequirement'],
      status: json['status'],
      plantingDate: DateTime.parse(json['plantingDate']),
      notes: json['notes'], // Ensure notes is correctly parsed
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'size': size,
      'lightRequirement': lightRequirement,
      'waterRequirement': waterRequirement,
      'soilRequirement': soilRequirement,
      'status': status,
      'plantingDate': plantingDate.toIso8601String(),
      'notes': notes, // Ensure this is included
      'image': image,
    };
  }
}
