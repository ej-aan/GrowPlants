import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GardenPlannerScreen extends StatefulWidget {
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
  File? _image;

  final Color _iconColor = const Color(0xFF8CB369);

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _plantingDate) {
      setState(() {
        _plantingDate = pickedDate;
      });
    }
  }

  
  void _savePlant() {
    if (_formKey.currentState?.validate() ?? false) {
      
      Navigator.pop(context);
    }
  }
}
