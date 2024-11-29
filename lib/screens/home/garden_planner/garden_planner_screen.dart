import 'package:flutter/material.dart';
import 'package:growplants/services/data_service.dart';  // Pastikan untuk mengimpor DataService
import 'package:growplants/screens/home/garden_manager/models/plant_model.dart';    // Pastikan untuk mengimpor model Plant

class GardenPlannerScreen extends StatefulWidget {
  final Plant? plant;  // Menambahkan final untuk parameter plant
  const GardenPlannerScreen({super.key, this.plant});  // Pastikan untuk menerima parameter plant dalam konstruktor

  @override
  _GardenPlannerScreenState createState() => _GardenPlannerScreenState();
}

class _GardenPlannerScreenState extends State<GardenPlannerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedType = 'Vegetable';
  String _selectedSize = 'Small';
  String _selectedLight = 'Full Sun';
  String _selectedWater = 'Medium';
  String _selectedSoil = 'Well-drained';
  String _selectedStatus = 'Seedling';
  DateTime? _plantingDate;
  String _selectedWaterSchedule = 'Once a day'; // New field for water schedule

  final Color _iconColor = const Color(0xFF8CB369);

  @override
  void initState() {
    super.initState();

    // If a plant is provided (i.e., for editing), populate the fields
    if (widget.plant != null) {
      _nameController.text = widget.plant!.name;
      _selectedType = widget.plant!.type;
      _selectedSize = widget.plant!.size ?? 'Small';  // Default to 'Small' if null
      _selectedWaterSchedule = widget.plant!.waterSchedule ?? 'Once a day'; // Default to 'Once a day' if null
      _selectedLight = widget.plant!.light ?? 'Full Sun';  // Default to 'Full Sun' if null
      _selectedSoil = widget.plant!.soil ?? 'Well-drained';  // Default to 'Well-drained' if null
      _selectedStatus = widget.plant!.status ?? 'Seedling';  // Default to 'Seedling' if null
      _plantingDate = widget.plant!.plantingDate;

      // Hanya set nilai notes di controller
      _notesController.text = widget.plant!.notes ?? '';  // Pastikan untuk mengganti dengan notes yang sesungguhnya
    }
  }

  // Save plant to the database (via DataService)
  void _savePlant() {
    if (_formKey.currentState?.validate() ?? false) {
      final newPlant = Plant(
        id: widget.plant?.id ?? DateTime.now().toString(),  // Use existing ID if editing, else generate a new one
        name: _nameController.text,
        type: _selectedType,
        size: _selectedSize,
        waterSchedule: _selectedWaterSchedule,
        plantingDate: _plantingDate,
        soil: _selectedSoil,
        light: _selectedLight,
        notes: _notesController.text,
        status: _selectedStatus,
      );

      // Save the plant using DataService (handle both add and update scenarios)
      if (widget.plant == null) {
        DataService().addPlant(newPlant);  // Add new plant
      } else {
        DataService().updatePlant(newPlant);  // Update existing plant
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _iconColor,
        title: const Text('Add New Plant'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Plant Name',
                icon: Icons.local_florist,
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Plant Type',
                value: _selectedType,
                icon: Icons.category,
                items: ['Vegetable', 'Fruit', 'Herb', 'Flower', 'Tree'],
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  _plantingDate == null
                      ? 'Select Planting Date'
                      : 'Planting Date: ${_plantingDate?.toLocal().toString().split(' ')[0]}',
                ),
                trailing: Icon(Icons.calendar_today, color: _iconColor, size: 20),
                onTap: _pickDate,
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Plant Size',
                value: _selectedSize,
                icon: Icons.straighten,
                items: ['Small', 'Medium', 'Large'],
                onChanged: (value) {
                  setState(() {
                    _selectedSize = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Light Requirement',
                value: _selectedLight,
                icon: Icons.wb_sunny,
                items: ['Full Sun', 'Partial Shade', 'Shade'],
                onChanged: (value) {
                  setState(() {
                    _selectedLight = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Water Requirement',
                value: _selectedWater,
                icon: Icons.opacity,
                items: ['Low', 'Medium', 'High'],
                onChanged: (value) {
                  setState(() {
                    _selectedWater = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Soil Requirement',
                value: _selectedSoil,
                icon: Icons.terrain,
                items: ['Well-drained', 'Clay', 'Sandy'],
                onChanged: (value) {
                  setState(() {
                    _selectedSoil = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _notesController,
                label: 'Notes / Care Tips',
                icon: Icons.notes,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Growth Status',
                value: _selectedStatus,
                icon: Icons.timeline,
                items: ['Seedling', 'Growing', 'Mature'],
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Watering Schedule',
                value: _selectedWaterSchedule,
                icon: Icons.water_drop,
                items: ['Once a day', 'Twice a day', 'Every other day', 'Once a week'],
                onChanged: (value) {
                  setState(() {
                    _selectedWaterSchedule = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4A259),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: _savePlant,
                child: const Text(
                  'Add Plant',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for building text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _iconColor, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: _iconColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: _iconColor, width: 1),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Helper method for building dropdown fields
  Widget _buildDropdownField({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _iconColor, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: _iconColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: _iconColor, width: 1),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  // Function to pick a date
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _plantingDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _plantingDate) {
      setState(() {
        _plantingDate = picked;
      });
    }
  }
}