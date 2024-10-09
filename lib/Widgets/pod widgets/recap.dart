import 'package:flutter/material.dart';

import '../bottoni/share_button_widget.dart';

class RecapWidget extends StatelessWidget {
  const RecapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colonna con la data di oggi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Oggi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          // Colonna con il messaggio principale
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complimenti!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'Sei stato 9 ore in meno di ieri al telefono ristorando una statua',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Bottone ShareButton all'estrema destra
          ShareButton(
            onPressed: () {
              // Aggiungi l'azione del bottone qui
            },
          ),
        ],
      ),
    );
  }
}