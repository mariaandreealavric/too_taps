import 'package:flutter/material.dart';
import 'package:too_taps/Widgets/bottoni/share_button_widget.dart';

import '../../controllers/Contatori/goal_controller.dart';
import '../../controllers/share_controller.dart';


class RewardWidget extends StatelessWidget {
  final Goal goal;

  const RewardWidget({Key? key, required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShareController shareController = ShareController(postText: "Ho raggiunto ${goal.name}!", postImageUrl: "");

    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Prima Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on, size: 40, color: Colors.black),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Punto Raggiunto!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ShareButton(shareController: shareController),

            ],
          ),
          const SizedBox(height: 8),
          // Seconda Row con i dati dinamici dell'obiettivo
          Row(
            children: [
              const Icon(Icons.star, size: 60, color: Colors.black), // Icona
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    goal.description,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Terza Row con i dettagli della distanza
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Distanza: ${goal.distance} milioni di km',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coordinate spaziali: ${goal.coordinates}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
