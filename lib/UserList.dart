import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:practical2_database/UserDetails.dart';
import 'package:practical2_database/UserEdit.dart';
import 'package:practical2_database/model/user_db.dart';
import 'UserCreate.dart';
import 'validations/validations.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  // Referencing the hive box
  final userBox = Hive.box('userBox');

  UserDB userDB = UserDB();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if the app has been opened for the first time ever
    if (userBox.get('userData') == null) {
      userDB.generateInitialUsersData();
    }
    // else if there is some data in the database
    else {
      userDB.loadUserData();
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // List userList = [
  //   {
  //     'name': 'Name1',
  //     'gender': 'Male',
  //     'phone': 'Phone1',
  //   },
  //   {
  //     'name': 'Name2',
  //     'gender': 'Female',
  //     'phone': 'Phone2',
  //   },
  //   {
  //     'name': 'Name3',
  //     'gender': 'Other',
  //     'phone': 'Phone3',
  //   },
  // ];

  // adding user - changing the data
  void addUserToList() {
    String name = nameController.value.text;
    String gender = genderController.value.text;
    String phone = phoneController.value.text;
    if (validateName(name) && validateGender(gender) && validatePhone(phone)) {
      var newUser = {'name': name, 'gender': gender, 'phone': phone};

      setState(() {
        userDB.userList.add(newUser);
        userDB.updateDatabase();

        Navigator.of(context).pop();
        nameController.clear();
        genderController.clear();
        phoneController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.yellow.shade200,
            content: SizedBox(
              width: 200,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gender or Phone is invalid',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Ok'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  // adding user - passed as callback to the button
  void addUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserCreate(
          nameController: nameController,
          genderController: genderController,
          phoneController: phoneController,
          onSubmit: addUserToList,
        ),
      ),
    );
  }

  // deleting user - performing updation on the data
  void deleteUserFromList(int index) {
    setState(() {
      userDB.userList.removeAt(index);
      userDB.updateDatabase();

      Navigator.of(context).pop();
    });
  }

  // deleting user - passed as callback to the button
  void deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.yellow.shade200,
        content: SizedBox(
          width: 200,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Are you sure you want to delete this user?'),
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Confirm'),
                    onPressed: () => deleteUserFromList(index),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow.shade400),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // editing user - edit the user data in the list
  void editUserInList(int index) {
    String name = nameController.value.text;
    String gender = genderController.value.text;
    String phone = phoneController.value.text;

    if (validateName(name) && validateGender(gender) && validatePhone(phone)) {
      var updatedUser = {
        'name': name,
        'gender': gender,
        'phone': phone,
      };

      setState(() {
        userDB.userList[index] = updatedUser;
        userDB.updateDatabase();
      });
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.yellow.shade200,
            content: SizedBox(
              width: 200,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gender or Phone is invalid',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Ok'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  // editing user - passed as callback to the button
  void editUser(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserEdit(
                userCurrentData: userDB.userList[index],
                nameController: nameController,
                genderController: genderController,
                phoneController: phoneController,
                onSubmit: () => editUserInList(index))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of users'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addUser,
        child: Icon(Icons.person_add_alt_1),
      ),
      body: ListView.builder(
        itemCount: userDB.userList.length,
        itemBuilder: (context, index) {
          return UserTile(
            name: userDB.userList[index]['name'],
            gender: userDB.userList[index]['gender'],
            phone: userDB.userList[index]['phone'],
            editUser: () => editUser(index),
            deleteUser: () => deleteUser(index),
          );
        },
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.name,
    required this.gender,
    required this.phone,
    required this.editUser,
    required this.deleteUser,
  });

  final String name;
  final String gender;
  final String phone;
  final VoidCallback editUser;
  final VoidCallback deleteUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow.shade300,
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 2,
          ),
        ),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(name),
            subtitle: Text("$gender"),
            trailing: Icon(Icons.arrow_right),
            tileColor: Colors.yellow.shade300,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => UserDetails(
                          name: name,
                          gender: gender,
                          phone: phone,
                        )),
                  ));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UserTile_Action(
                buttonType: 'Edit',
                action: editUser,
              ),
              UserTile_Action(
                buttonType: 'Delete',
                action: deleteUser,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class UserTile_Action extends StatelessWidget {
  const UserTile_Action({
    super.key,
    required this.buttonType,
    required this.action,
  });

  final String buttonType;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: InkWell(
        child: Row(
          children: [
            Icon(
              buttonType.toLowerCase() == 'edit' ? Icons.edit : Icons.delete,
              size: 16,
            ),
            Text(buttonType),
          ],
        ),
        onTap: action,
      ),
    );
  }
}
