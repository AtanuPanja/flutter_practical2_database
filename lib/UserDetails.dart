import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.name,
    required this.gender,
    required this.phone,
  });

  final String name;
  final String gender;
  final String phone;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: screenWidth / 1.5,
          height: screenHeight / 2.5,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(offset: Offset(2,2),),
            ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0,),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepOrange.shade700,
                foregroundColor: Colors.white,
                child: Icon(
                  Icons.person_outlined,
                  size: 50,
                ),
                radius: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayLabel(
                    heading: 'Name: ',
                    content: name,
                  ),
                  DisplayLabel(
                    heading: 'Gender: ',
                    content: gender,
                  ),
                  DisplayLabel(
                    heading: 'Phone number: ',
                    content: phone,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayLabel extends StatelessWidget {
  const DisplayLabel({
    super.key,
    required this.heading,
    required this.content,
  });

  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
        ),
        children: <TextSpan>[
        TextSpan(
          text: heading,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: content,
        ),
      ]),
    );
  }
}
