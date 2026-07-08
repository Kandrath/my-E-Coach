import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final Function(String, int, String, double, double) onSave;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.onSave,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late String _name;
  late int _age;
  late String _gender;
  late double _height;
  late double _weight;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _age = widget.age;
    _gender = widget.gender;
    _height = widget.height;
    _weight = widget.weight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2C3E50),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFA2B997),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              
              _buildTextField('Nom', _name, (value) => _name = value),
              const SizedBox(height: 15),
              
              Row(
                children: [
                  Expanded(child: _buildNumberField('Âge', _age.toString(), (value) => _age = int.parse(value))),
                  const SizedBox(width: 15),
                  Expanded(child: _buildDropdownField('Genre', _gender, ['Homme', 'Femme', 'Autre'], (value) => _gender = value!)),
                ],
              ),
              const SizedBox(height: 15),
              
              Row(
                children: [
                  Expanded(child: _buildNumberField('Taille (cm)', _height.toString(), (value) => _height = double.parse(value))),
                  const SizedBox(width: 15),
                  Expanded(child: _buildNumberField('Poids (kg)', _weight.toString(), (value) => _weight = double.parse(value))),
                ],
              ),
              
              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onSave(_name, _age, _gender, _height, _weight);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profil mis à jour !')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA2B997),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('ENREGISTRER', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onSave) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
      ),
      onSaved: (value) => onSave(value!),
    );
  }

  Widget _buildNumberField(String label, String initialValue, Function(String) onSave) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
      ),
      onSaved: (value) => onSave(value!),
    );
  }

  Widget _buildDropdownField(String label, String currentValue, List<String> options, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }
}
