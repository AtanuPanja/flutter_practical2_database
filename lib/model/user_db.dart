import 'package:hive_flutter/hive_flutter.dart';

class UserDB {

  List userList = [];

  // reference the users box
  final userBox = Hive.box('userBox');

  // if the app is being used for the first time ever
  void generateInitialUsersData() {
      userList = [
      {
        'name': 'Name1',
        'gender': 'Male',
        'phone': 'Phone1',
      },
      {
        'name': 'Name2',
        'gender': 'Female',
        'phone': 'Phone2',
      },
      {
        'name': 'Name3',
        'gender': 'Other',
        'phone': 'Phone3',
      },
    ];
  }

  void loadUserData() async {
    userList = await userBox.get('userData');
  }


  void updateDatabase() {
    userBox.put('userData', userList);
  }
}