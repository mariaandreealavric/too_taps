import 'package:flutter/material.dart';

class JobTitle extends StatelessWidget {
  final String jobTitle;

  const JobTitle({
    Key? key,
    required this.jobTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      jobTitle,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontStyle: FontStyle.normal,
        fontFamily: 'KeplerStd',
      ),
    );
  }
}