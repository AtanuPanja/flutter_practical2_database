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
  /*
    the loadUserData was an async method, so, when the app was opened after restart of the phone, the data was not visible. Only when a new data 
    was being added, using the add button, then all the data was displayed.
    On removing the async await, from loadUserData method, this issue got resolved
   */
  void loadUserData() {
    userList = userBox.get('userData');
  }


  void updateDatabase() {
    userBox.put('userData', userList);
  }
}