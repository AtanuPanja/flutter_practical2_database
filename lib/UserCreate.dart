import 'package:flutter/material.dart';

class UserCreate extends StatelessWidget {
  const UserCreate({
    super.key,
    required this.nameController,
    required this.genderController,
    required this.phoneController,
    required this.onSubmit,
  });

  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController phoneController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              UserInputField(
                controller: nameController,
                placeholder: 'Name',
                icon: Icon(Icons.person),
              ),
              UserInputField(
                controller: genderController,
                placeholder: 'Gender',
                icon: Icon(Icons.person),
              ),
              UserInputField(
                controller: phoneController,
                placeholder: 'Phone',
                icon: Icon(Icons.phone),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class UserInputField extends StatelessWidget {
  const UserInputField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.icon,
  });
  
  final TextEditingController controller;
  final String placeholder;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          contentPadding: EdgeInsets.all(8.0),
          prefixIcon: icon,
        ),
      ),
    );
  }
}