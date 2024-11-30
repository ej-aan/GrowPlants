import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../models/plant_model.dart';
import '../../../services/data_service.dart';

class PlantForm extends StatefulWidget {
  final Plant plant; // Edit mode only, assuming a plant is always passed.

  const PlantForm({super.key, required this.plant});

  @override
  _PlantFormState createState() => _PlantFormState();
}

class _PlantFormState extends State<PlantForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _notesController;

  // Dropdown values and image
  late String _selectedType;
  late String _selectedSize;
  late String _selectedLight;
  late String _selectedWater;
  late String _selectedSoil;
  late String _selectedStatus;
  late DateTime? _plantingDate;
  File? _image;

  final Color _iconColor = const Color(0xFF8CB369);

  @override
  void initState() {
    super.initState();

    // Initialize fields with existing values from the plant object
    _nameController = TextEditingController(text: widget.plant.name);
    _notesController = TextEditingController(text: widget.plant.notes);
    _selectedType = widget.plant.type;
    _selectedSize = widget.plant.size;
    _selectedLight = widget.plant.lightRequirement;
    _selectedWater = widget.plant.waterRequirement;
    _selectedSoil = widget.plant.soilRequirement;
    _selectedStatus = widget.plant.status;
    _plantingDate = widget.plant.plantingDate;
    _image = widget.plant.image != null ? File(widget.plant.image!) : null;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _savePlant() {
    if (_formKey.currentState!.validate()) {
      // Update plant object with new values
      widget.plant
        ..name = _nameController.text
        ..type = _selectedType
        ..size = _selectedSize
        ..lightRequirement = _selectedLight
        ..waterRequirement = _selectedWater
        ..soilRequirement = _selectedSoil
        ..status = _selectedStatus
        ..notes = _notesController.text
        ..plantingDate = _plantingDate!
        ..image = _image?.path;

      // Update the plant using DataService
      DataService().updatePlant(widget.plant);

      Navigator.pop(context); // Return to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CB369),
        title: const Text('Edit Plant'),
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
                trailing:
                    Icon(Icons.calendar_today, color: _iconColor, size: 20),
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
              _image == null
                  ? TextButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.image, color: _iconColor, size: 20),
                      label: Text('Upload Image'),
                    )
                  : Column(
                      children: [
                        Image.file(_image!),
                        TextButton(
                          onPressed: _pickImage,
                          child: Text('Change Image'),
                        ),
                      ],
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
                  'Edit Plant',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildDropdownField({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
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
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _plantingDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _plantingDate = pickedDate; // This ensures a non-null value
      });
    }
  }
}
