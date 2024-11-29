class Plant {
  final String id;
  String name;
  String type;
  String? size;  // Optional: Adding size for the plant (Small, Medium, Large)
  String? waterSchedule;  // Optional: Adding watering schedule info (Once a day, etc.)
  DateTime? plantingDate; // Optional: Date when the plant was planted
  String? soil; // Optional: Soil type (Well-drained, Sandy, etc.)
  String? light; // Optional: Light requirement (Full Sun, Shade, etc.)
  String? status; // Optional: Growth status (Seedling, Growing, Mature)
  String? notes;  // Optional: Notes or care tips for the plant

  Plant({
    required this.id,
    required this.name,
    required this.type,
    this.size,
    this.waterSchedule,
    this.plantingDate,
    this.soil,
    this.light,
    this.status,
    this.notes,  // Add notes as an optional parameter
  });

  // Convert Plant object to JSON (for saving to database or API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'size': size,
      'waterSchedule': waterSchedule,
      'plantingDate': plantingDate?.toIso8601String(),  // Convert DateTime to String
      'soil': soil,
      'light': light,
      'status': status,
      'notes': notes,  // Add notes to the JSON conversion
    };
  }

  // Create a Plant object from JSON (for loading from database or API)
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      waterSchedule: json['waterSchedule'],
      plantingDate: json['plantingDate'] != null
          ? DateTime.parse(json['plantingDate'])
          : null,  // Convert String to DateTime if it exists
      soil: json['soil'],
      light: json['light'],
      status: json['status'],
      notes: json['notes'],  // Add notes while parsing from JSON
    );
  }

  // Optional: Method to update certain fields (e.g., editing a plant's name or type)
  void update({
    String? newName,
    String? newType,
    String? newSize,
    String? newWaterSchedule,
    DateTime? newPlantingDate,
    String? newSoil,
    String? newLight,
    String? newStatus,
    String? newNotes,  // Add newNotes parameter for updating notes
  }) {
    if (newName != null) name = newName;
    if (newType != null) type = newType;
    if (newSize != null) size = newSize;
    if (newWaterSchedule != null) waterSchedule = newWaterSchedule;
    if (newPlantingDate != null) plantingDate = newPlantingDate;
    if (newSoil != null) soil = newSoil;
    if (newLight != null) light = newLight;
    if (newStatus != null) status = newStatus;
    if (newNotes != null) notes = newNotes;  // Update the notes field
  }

  // Optional: Helper method to print a nice string representation of the plant
  @override
  String toString() {
    return 'Plant{id: $id, name: $name, type: $type, size: $size, light: $light, status: $status, notes: $notes}';
  }
}
