import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final String userName;

  const ProfileName({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'KeplerStd',
      ),
    );
  }
}