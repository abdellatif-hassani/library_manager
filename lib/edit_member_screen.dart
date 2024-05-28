import 'package:flutter/material.dart';
import 'members_screen.dart';

class EditMemberScreen extends StatefulWidget {
  final Member member;
  final int index;
  final Function editMember;

  EditMemberScreen({required this.member, required this.index, required this.editMember});

  @override
  _EditMemberScreenState createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _name = widget.member.name;
    _imageUrl = widget.member.image;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.editMember(
        widget.index,
        _name,
        _imageUrl.isEmpty ? 'assets/member1.png' : _imageUrl,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le Membre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              TextFormField(
                initialValue: _imageUrl,
                decoration: InputDecoration(labelText: 'URL de l\'image'),
                onSaved: (value) {
                  _imageUrl = value ?? '';
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Modifier le Membre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
