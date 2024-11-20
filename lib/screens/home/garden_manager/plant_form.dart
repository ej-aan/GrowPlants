import 'package:flutter/material.dart';
import 'models/plant_model.dart';
import '../../../services/data_service.dart';

class PlantForm extends StatefulWidget {
  final Plant? plant;

  const PlantForm({super.key, this.plant});

  @override
  _PlantFormState createState() => _PlantFormState();
}

class _PlantFormState extends State<PlantForm> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String type;
  String? notes;

  @override
  void initState() {
    super.initState();
    name = widget.plant?.name ?? '';
    type = widget.plant?.type ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8CB369),
        title: Text(widget.plant == null ? 'Add Plant' : 'Edit Plant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Plant Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
                onSaved: (value) => type = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePlant,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePlant() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.plant == null) {
        DataService().addPlant(Plant(
          id: DateTime.now().toString(),
          name: name,
          type: type,
        ));
      } else {
        widget.plant!
          ..name = name
          ..type = type;
        DataService().updatePlant(widget.plant!);
      }
      Navigator.pop(context);
    }
  }
}
