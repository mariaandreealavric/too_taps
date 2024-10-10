import 'package:flutter/material.dart';
import 'package:too_taps/Widgets/bottoni/red_follow_botton.dart';
import 'package:too_taps/Widgets/graphics/profile_name_widget.dart';
import '../graphics/job_title_widget.dart';
import '../graphics/red_circle_avatar_widget.dart';
import '../../models/profile_model.dart';

class SuggestedProfileWidget extends StatelessWidget {
  final ProfileModel profile;


  const SuggestedProfileWidget({
    Key? key,
    required this.profile,
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
                RedCircleAvatar(imageUrl: profile.photoUrl),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileName(userName: profile.displayName),
                    JobTitle(jobTitle: profile.jobTitle),
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
              child: Image.asset(
                profile.postImage,
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
