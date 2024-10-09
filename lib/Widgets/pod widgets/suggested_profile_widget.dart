import 'package:flutter/material.dart';
import 'package:too_taps/Widgets/bottoni/red_follow_botton.dart';
import 'package:too_taps/Widgets/graphics/profile_name_widget.dart';

import '../graphics/job_title_widget.dart';
import '../graphics/red_circle_avatar_widget.dart';

class SuggestedProfileWidget extends StatelessWidget {
  final String userName;
  final String jobTitle;
  final String profileImageUrl;
  final String postImageUrl;

  const SuggestedProfileWidget({
    Key? key,
    required this.userName,
    required this.jobTitle,
    required this.profileImageUrl,
    required this.postImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Parte sinistra: CircleAvatar, nome utente e job title
                const RedCircleAvatar(imageUrl: ''),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileName(userName: 'Monica Neri'),
                    JobTitle(jobTitle: 'Technician'),
                  ],
                ),
                Spacer(),
                // Parte destra: Bottone Segui
                RedFollowButton(onPressed: () {}),
              ],
            ),
          ),
          // Immagine che copre il resto del container
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: Image.network(
                postImageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}