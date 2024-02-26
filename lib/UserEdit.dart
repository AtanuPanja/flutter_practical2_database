import 'package:flutter/material.dart';

class UserEdit extends StatelessWidget {
  const UserEdit({
    super.key,
    required this.userCurrentData,
    required this.nameController,
    required this.genderController,
    required this.phoneController,
    required this.onSubmit,
  });

  // getting the currentData of the user,
  // and then filling the controllers with that data, such that
  // the it can be updated easily
  // this is different from the add user page, where the fields are empty
  final Map userCurrentData;
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController phoneController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              UserInputField(
                initialText: userCurrentData['name'],
                controller: nameController,
                placeholder: 'Name',
                icon: Icon(Icons.person),
              ),
              UserInputField(
                initialText: userCurrentData['gender'],
                controller: genderController,
                placeholder: 'Gender',
                icon: Icon(Icons.person),
              ),
              UserInputField(
                initialText: userCurrentData['phone'],
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
    required this.initialText,
    required this.controller,
    required this.placeholder,
    required this.icon,
  });
  
  // setting the initialText with the user's current data
  final String initialText;
  final TextEditingController controller;
  final String placeholder;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    controller.text = initialText;
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